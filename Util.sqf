Play3DSound = {
  params [
    "_filename",
    "_sourceObject",
    ["_dB", 18],
    ["_pitch", 1],
    ["_falloff", 50]
  ];

  _soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
  _soundToPlay = _soundPath + "fx\" + _filename + ".ogg";

  playSound3D [
    _soundToPlay,
    _sourceObject,
    false,
    AGLtoASL position _sourceObject,
    _dB,
    _Pitch,
    _falloff
  ];
};


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
  ["here2", "hint", true, true] call BIS_fnc_MP;
  params [
    "_target",
    "_name",
    "_script",
    "_distance",
    ["_params", []]
  ];

  hint format ["%1\n%2", _this select 0, _target];

  _extraArguments    = [];
  _defaultPriority   = 1.5;
  _defaultShowWindow = true;
  _defaultHideOnUse  = true;
  _defaultShortcut   = "";
  _defaultCondition = "true";
  /* _defaultCondition  = "_this distance _target < _distance"; */

  ["here3", "hint", true, true] call BIS_fnc_MP;
  [format ["_target: %1", _target], "hint", true, true] call BIS_fnc_MP;
  /* _target addAction [
    _name,
    _script,
    _params,
    _defaultPriority,
    _defaultShowWindow,
    _defaultHideOnUse,
    _defaultShortcut,
    "
      [format ['_this: %1\n_target: %2', _this, _target], 'hint', true, true] call BIS_fnc_MP;
      _show = (_this distance _target) < 3;
      true
    "
  ]; */

  [
    [
      _target,
      [
        _name,
        _script,
        _params,
        _defaultPriority,
        _defaultShowWindow,
        _defaultHideOnUse,
        _defaultShortcut,
        _defaultCondition,
        _distance
      ]
  ], "addAction", true, true] call BIS_fnc_MP;

  /* _target addAction [
    _name,
    _script,
    _params,
    _defaultPriority,
    _defaultShowWindow,
    _defaultHideOnUse,
    _defaultShortcut,
    '
      hint format ["vehicle _this: %1\nplayer: %2", vehicle _this, player];
      _show = false;
      if ( vehicle _this == player ) then {
        _show = true;
      } else {
        _show = false;
      };
      _show
    ',
    _distance
  ]; */

  /* _action = _target addAction [
    _name,
    /* { 0 = [ _script, "remoteExec" , 0, true] call BIS_fnc_MP; }, */
    /* _script,
    _params,
    _defaultPriority,
    _defaultShowWindow,
    _defaultHideOnUse,
    _defaultShortcut, */
    /* "(_target distance _this) < 2" */
    /* "true" */
  /* ]; */

  /* [
    _target,
    [_name, _script, _params, _defaultPriority, false, true, "", "_this distance _target < 2"]
  ] remoteExec ["addAction", 0, true]; */


  /* if (isServer) then { */
    /* [_target [
    _name,
    _script,
    _params,
    _defaultPriority,
    _defaultShowWindow,
    _defaultHideOnUse,
    _defaultShortcut,
    "hint format ['%1\n%2\n%3', _this, _target, (player distance _target)];
    (player distance _target) < 3"
    ]] remoteExec ["addAction"]; */

    /* [
      [
        _name,
        _script,
        _params
      ],
      "addAction",
      true,
      true
    ] call BIS_fnc_MP; */

    /* [
      [_name, _script, _params],
      "addAction",
      true,
      true
    ] call BIS_fnc_MP; */
  /* }; */
};

HintPlayer = {
  _player = _this select 0;
  _message = _this select 1;

  if (name _player == name player) then {
    hint _message;
  };
};
