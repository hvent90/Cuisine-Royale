StoreFood = {
  params ["", "_player"];

  _foodOnPlayer = _player getVariable "foodOnPerson";
  _foodInBase = _player getVariable "foodInBase";

  _player setVariable ["foodInBase", _foodInBase + _foodOnPlayer];
  _player setVariable ["foodOnPlayer", 0];

  _message = format ["Food in base: %1", _player getVariable "foodInBase"];
  [_player, _message] call HintPlayer;
};

CreatePlayerBases = {
  spawns = [
    "respawn_west",
    "respawn_east",
    "respawn_guerrila"
  ];

  {
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

    _table = createSimpleObject [
      "Land_TableBig_01_F",
      AGLtoASL _tableLocation
    ];

    _microwave = createSimpleObject [
      "Land_Microwave_01_F",
      AGLtoASL _microwaveLocation
    ];

    _fridge = createVehicle [
      "Fridge_01_closed_F",
      _fridgeLocation, [],
      0, "CAN_COLLIDE"
    ];

    [_fridge, "Store food", "call StoreFood", 1] call AddLiteAction;
  } forEach spawns;
};
