OnPlayerKill = {
  params ["_unit"];
  _foodAmount = _unit getVariable "foodOnPerson";

  if (_foodAmount > 0) then {
    [_unit, _foodAmount] call InitSupplyCrate;
    _unit setVariable ['foodOnPerson', 0];
  };
};

CallReinforcementAction = {
  params ["_unit", "_vehicle"];

  [_unit, _vehicle] call CallReinforcement;

  _foodAmount = _unit getVariable "foodInBase";
  _unit setVariable ["foodInBase", _foodAmount - 15];

  hint format ["Food remaining: %1", _unit getVariable "foodInBase"];
};

CreatePlayerInventory = {
  _sides = [];

  {
    _sides append [side _x];
    _player = _x;

    _player setVariable ["foodOnPerson", 15];
    _player setVariable ["foodInBase", 0];

    [_player, 15] call InitSupplyCrate;

    _player addEventHandler ["killed", {
      params ["_unit"];
      _unit call OnPlayerKill;
    }];

    // Prevent player's "side" from going to ENEMY upon friendly fire
    _player addEventHandler ["HandleRating", {
      params["_unit"];

      if (rating _unit < 0) then {
        player addRating abs rating _unit;
      };
    }];

    _player addAction [
      "Call Armed Car Reinforcement",
      "[_this select 1, 0] call CallReinforcementAction;",
      [],
      1.5,
      false,
      true,
      "",
      "_this getVariable 'foodInBase' > 14;"
    ];
  } forEach allUnits;
};
