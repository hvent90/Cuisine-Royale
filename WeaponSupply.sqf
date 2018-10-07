DropWeaponsCrate = {
  _groupLeader = this;

  _crate = createSimpleObject [
    "Land_FoodSacks_01_large_brown_idap_F",
    AGLtoASL (_groupLeader getPos [5, random 360])
  ];
};

ExitWeaponSupply = {
  _groupLeader = this;
  _veh = vehicle _groupLeader;

	{ deleteVehicle _x; } forEach (crew _veh);
	deleteVehicle _veh;
};

InitWeaponSupply = {
  _dropoffs = [
    weapon_dropoff_2,
    weapon_dropoff_3
  ];

  _dropoff = selectRandom _dropoffs;

  _position = _dropoff getPos [300, random 360];
  _veh = createVehicle ["C_Offroad_01_repair_F", _position, [], random 360];
  createVehicleCrew _veh;

  _group = group ((crew _veh) select 0);
  _wp = _group addWaypoint [position _dropoff, 2];
  _wp setWaypointBehaviour "SAFE";
  _wp setWaypointSpeed "LIMITED";
  _wp setWaypointStatements ["true", "[] call DropWeaponsCrate"];

  _wpExit = _group addWaypoint [_veh getPos [300, random 360], 0];
  _wpExit setWaypointCompletionRadius 100;
  _wpExit setWaypointStatements ["true", "[] call ExitWeaponSupply"];
};
