
class Database{
    constructor(){
        if(this.instance)return this.instance;
        Database.instance=this;
        const admin=require('firebase-admin'); // To access Firestore API
        admin.initializeApp({
            credential: admin.credential.applicationDefault(),
        });
        this.firestore=admin.firestore();

    }

    //CRUD operation
    //create
    async create(collection,document){       //POST request
        const result = await this.firestore.collection(collection).add(document)
        document.id = result.id
        return document
    }

    //read
    async getList(collection) {         //GET request, get all data
        const result = await this.firestore.collection(collection).get()

        const list = []
        result.forEach((doc) => {
            const data = doc.data()
            data.id = doc.id
            list.push(data)
        })
        return list.length ? list : null
    }

    async get(collection, id) {      //GET request, get specific data
        const result = await this.firestore.collection(collection).doc(id).get()
        if (!result.exists) return null  // Record not found

        const doc = result.data()
        doc.id = result.id
        return doc
    }

    //update
    async set(collection, id, document) {       //PUT or PATCH request, update data
        const doc = this.firestore.collection(collection).doc(id)
        const result = await doc.get()

        if (!result.exists) return null  // Record not found

        await doc.set(document)

        document.id = id
        return document
    }

    //delete
    async delete(collection, id) {      //DELETE request
        const doc = this.firestore.collection(collection).doc(id)
        const result = await doc.get()

        if (!result.exists) return null // Record not found

        await doc.delete()

        return { id }
    }


}

module.exports = new Database()