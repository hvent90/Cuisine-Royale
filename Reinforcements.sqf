Loiter = {
	_veh = _this select 0;
	_player = _this select 1;
	_vehicleReady = _this select 2;
	_loiterDistance = _this select 3;

	_group = group ((crew _veh) select 0);
	_loitering = true;

	_pos = _player getPos [_loiterDistance * sqrt random 1, random 360];
	_group move _pos;

	waituntil {[_veh] call _vehicleReady};

	[_veh, _loitering, _player, _vehicleReady, _group, _loiterDistance] spawn {
		_veh = _this select 0;
		_loitering = _this select 1;
		_player = _this select 2;
		_vehicleReady = _this select 3;
		_group = _this select 4;
		_loiterDistance = _this select 5;

		while { alive _veh && _loitering } do {
			_pos = _player getPos [_loiterDistance * sqrt random 1, random 360];
			_group move _pos;
			waituntil {[_veh] call _vehicleReady};
		};
	};

  sleep 60;

	_veh doMove (_player getPos [1000, random 360]);
	sleep 30;
	{ deleteVehicle _x; } forEach (crew _veh);
	deleteVehicle _veh;
};

CallReinforcement = {
	_player = _this select 0;
  _playerSide = side player;
  _random = _this select 1;
  private ["_vehicle"];

	_vehicles = [
		["B_Heli_Transport_01_camo_F", 2000, 50],
		["B_T_LSV_01_armed_F", 200, 20]
	];

	if (_random < .8) then {
    _vehicle = _vehicles select 0;
  };

  if (_random < 1) then {
    _vehicle = _vehicles select 1;
  };

	_vehicleClass = _vehicle select 0;
	_distance = _vehicle select 1;
	_loiterDistance = _vehicle select 2;
	_position = _player getPos [_distance * sqrt random 1, random 360];

	_veh = createVehicle [_vehicleClass, _position, [], random 360, "FLY"];
	createVehicleCrew _veh;
  _group = createGroup _playerSide;

	{
    [_x] joinSilent grpNull;
    [_x] joinSilent _group;

		_x setSkill 1;
		_x setBehaviour "COMBAT";
		_x setCombatMode "YELLOW";
    _x assignTeam (assignedTeam _player);
	} forEach (crew _veh);

	[_veh, _player, VehicleReady, _loiterDistance] spawn Loiter;
};
