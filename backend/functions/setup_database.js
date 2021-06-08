const db = require('./api/database')

async function setupDatabase(req, res, next) {
    // To delete all the collections
    const collections = ['users', 'todos']
    collections.forEach(async (collection) => await deleteCollection(collection))

    // Add documents to the todos collection
    addDocuments(
        'users',
        [
            { name: 'Faiq',email : 'faiq@gmail.com',password:'faiq1234'},
            { name: 'Aniq',email : 'Aniq@gmail.com',password:'aniq1234'}            
        ]
    )

    res.send('Setting Up Database.... Done ')
}

async function deleteCollection(collection) {
    const cref = db.firestore.collection(collection)
    const docs = await cref.listDocuments()
    docs.forEach((doc) => doc.delete())
}

function addDocuments(collection, docs) {
    docs.forEach((doc) => db.create(collection, doc))
}

module.exports = setupDatabase