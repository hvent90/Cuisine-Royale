_target = _this select 0;
_caller = _this select 1;

[_caller, random 1] call CallReinforcement;

if (isServer)  then {
  _target hideObjectGlobal true;
  sleep 120;
  _target hideObjectGlobal false;
};
