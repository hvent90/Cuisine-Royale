  VehicleReady = {
    _veh = _this select 0;
    _ready = true;
    {
        if (!(isNull _x)) then
        {
            _ready = _ready && (unitReady _x);
        };
    } forEach [
        (commander _veh),
        (gunner _veh),
        (driver _veh)
    ];
    _ready
};

AddLiteAction = {
  params [
    "_target",
    "_name",
    "_script",
    "_radius",
    ["_params", []]
  ];

  _extraArguments    = [];
  _defaultPriority   = 1.5;
  _defaultShowWindow = true;
  _defaultHideOnUse  = true;
  _defaultShortcut   = "";
  _defaultCondition  = "true";

  _target addAction [
    _name,
    _script,
    _params,
    _defaultPriority,
    _defaultShowWindow,
    _defaultHideOnUse,
    _defaultShortcut,
    _defaultCondition,
    _radius
  ];
};

HintPlayer = {
  _player = _this select 0;
  _message = _this select 1;

  if (name _player == name player) then {
    hint _message;
  };
};
