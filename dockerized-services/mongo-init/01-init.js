// ./mongo-init/01-init.js
db = db.getSiblingDB('payments');
db.createUser({
    user: 'payments_user',
    pwd: 'payments_pass',
    roles: [{ role: 'readWrite', db: 'payments' }]
});
