OnHusbandAffection = {
  params ["_husband", "_player"];

  _husband lookAt _player;

  _sound = format ["husband_affection_%1", floor ((random 5) + 1)];
  [_sound, _husband] call Play3DSound;
};

StoreFood = {
  params ["_fridge", "_player"];

  _foodOnPlayer = _player getVariable "foodOnPerson";
  _foodInBase = _player getVariable "foodInBase";

  _player setVariable ["foodInBase", _foodInBase + _foodOnPlayer];
  _player setVariable ["foodOnPerson", 0];

  _message = format ["Food in base: %1", _player getVariable "foodInBase"];
  [_player, _message] call HintPlayer;
  ["put_in_fridge", _fridge, 5] call Play3DSound;

  _side = format ["%1", side _player];
  _table = missionNamespace getVariable ("table_" + _side);

  _pos = position _table;
  _husbandPosition = [
    (_pos select 0) + 2,
    _pos select 1,
    _pos select 2
  ];
  _grp = createGroup civilian;
  _husband = _grp createUnit [
    "C_man_p_beggar_F",
    _husbandPosition,
    [],
    0,
    "CAN_COLLIDE"
  ];


  _husbandName = "husband_" + _side;
  missionNamespace setVariable [_husbandName, _husband];
  _husband addEventHandler
    ["killed", "missionNamespace setVariable _husbandName nil;"];

  [_husband, "Show Basic Affection", "call OnHusbandAffection", 2] call AddLiteAction;

  _husband lookAt _player;
  sleep 2;
  ["husband_arrive", _husband] call Play3DSound;
};

CreatePlayerBases = {
  spawns = [
    "respawn_west",
    "respawn_east",
    "respawn_guerrila"
  ];

  {
    _side = "";
    switch (_x) do {
        case "respawn_east": {
            _side = "EAST";
        };

        case "respawn_west": {
            _side = "WEST";
        };

        case "respawn_guerrila": {
          _side = "GUER";
        };
    };

    _spawnLocation = getMarkerPos _x;
    _tableLocation = [
      (_spawnLocation select 0) + 2.5,
      (_spawnLocation select 1) + 2.5,
      _spawnLocation select 2
    ];
    _microwaveLocation = [
      _tableLocation select 0,
      _tableLocation select 1,
      (_tableLocation select 2) + .88
    ];
    _fridgeLocation = [
      (_tableLocation select 0) - 2,
      _tableLocation select 1,
      _tableLocation select 2
    ];

    _tent = createSimpleObject [
      "CamoNet_OPFOR_open_F",
      AGLtoASL _spawnLocation
    ];
    _tent setVariable ["side", _side];

    _table = createSimpleObject [
      "Land_TableBig_01_F",
      AGLtoASL _tableLocation
    ];
    _table setVariable ["side", _side];

    _microwave = createSimpleObject [
      "Land_Microwave_01_F",
      AGLtoASL _microwaveLocation
    ];
    _microwave setVariable ["side", _side];

    _fridge = createVehicle [
      "Fridge_01_closed_F",
      _fridgeLocation, [],
      0, "CAN_COLLIDE"
    ];
    _fridge setVariable ["side", _side];

    /* [_fridge, "Store food", "call StoreFood", 1.5] call AddLiteAction; */
    [[_fridge, "Store food", "call StoreFood", 1.5], "AddLiteAction", true, true] call BIS_fnc_MP;

    missionNamespace setVariable ["fridge_" + _side, _fridge];
    missionNamespace setVariable ["table_" + _side, _table];
    missionNamespace setVariable ["microwave_" + _side, _microwave];
  } forEach spawns;
};
