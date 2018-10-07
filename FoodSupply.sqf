OnFoodPickup = {
  params ["_crate", "_player", "", "_foodAmount"];
  deleteVehicle _crate;

  _message = format ["Picked up %1 food", _foodAmount];
  _player setVariable ['foodOnPerson', _foodAmount];
  [_player, _message] call HintPlayer;
};

InitSupplyCrate = {
  params [
    "_veh",
    ["_foodAmount", 15]
  ];

  _crate = createVehicle [
    "Land_FoodSacks_01_large_brown_idap_F",
    _veh getPos [1, random 360]
  ];

  [_crate, "Pickup Food", "call OnFoodPickup", 1.5, _foodAmount]
    call AddLiteAction;
};

InitFoodSupply = {
  _helipads = [
    helipad_1,
    helipad_2,
    helipad_3
  ];

  _helipad = selectRandom _helipads;

  _position = _helipad getPos [50, random 360];
  _veh = createVehicle [
    "C_Heli_Light_01_civil_F",
    _position, [], random 360, "FLY"
  ];

  createVehicleCrew _veh;
  _group = group ((crew _veh) select 0);
  [_group, position _helipad, _helipad] call BIS_fnc_wpLand;

  waitUntil {[_veh] call VehicleReady};
  sleep 3;

  _foodAmount = 15;
  [_veh, _foodAmount] call InitSupplyCrate;
  sleep 5;

  _veh doMove (_helipad getPos [1000, random 360]);
  sleep 30;

	{ deleteVehicle _x; } forEach (crew _veh);
	deleteVehicle _veh;
};
