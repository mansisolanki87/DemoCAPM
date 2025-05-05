using { db } from '../db/schema';

service demoservice {

    entity Users as projection on db.User;

}