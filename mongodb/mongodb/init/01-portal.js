db = db.getSiblingDB('portal');
db.createUser( 
    { 
        user: 'portal', 
        pwd: 's3cr37', 
        roles: [ 
            { 
                role: 'dbOwner', 
                db: 'portal' 
            } 
        ] 
    } 
);