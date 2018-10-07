_group = this select 0;
_position = this select 1;
_target = this select 2;
_veh = this select 3;

sleep 3;
_crate = createSimpleObject [
  "Land_FoodSacks_01_large_brown_idap_F",
  AGLtoASL (_veh getPos [5, random 360])
];
sleep 5;
