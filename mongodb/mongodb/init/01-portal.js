db = db.getSiblingDB('portal');
db.createUser( 
    { 
        user: 'portal', 
        pwd: 'p4ssw04d', 
        roles: [ 
            { 
                role: 'dbOwner', 
                db: 'portal' 
            } 
        ] 
    } 
);