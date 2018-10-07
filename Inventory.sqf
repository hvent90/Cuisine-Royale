OnPlayerKill = {
  params ["_unit"];
  _foodAmount = _unit getVariable "foodOnPerson";

  if (_foodAmount > 0) then {
    [_unit, _foodAmount] call InitSupplyCrate;
    _unit setVariable ['foodOnPerson', 0];
  };
};

CreatePlayerInventory = {
  {
    _player = _x;

    _player setVariable ["foodOnPerson", 15];
    _player setVariable ["foodInBase", 0];

    [_player, 15] call InitSupplyCrate;

    _player addEventHandler ["killed", {
      params ["_unit"];
      _unit call OnPlayerKill;
    }];
  } forEach allUnits;
};
