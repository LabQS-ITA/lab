portalDB = db.getSiblingDB('portal');
portalDB.createUser( { user: 'portal', pwd: 'p4ssw04d', roles: [ { role: 'dbOwner', db: 'portal' } ] } )