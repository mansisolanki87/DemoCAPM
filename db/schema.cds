namespace db;

using { managed } from '@sap/cds/common';


entity User :managed {
    key userid:UUID;
    username:String;
}

entity Department : managed {
    key deptid:UUID;
    departmentname:String;
}