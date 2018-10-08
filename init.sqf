_scripts = [
  execVM "Util.sqf",
  execVM "Playzone.sqf",
  execVM "Base.sqf",
  execVM "Inventory.sqf",
  execVM "FoodSupply.sqf",
  execVM "WeaponSupply.sqf",
  execVM "ServerLoops.sqf",
  execVM "Reinforcements.sqf"
];

{waitUntil {scriptDone _x;}} forEach _scripts;

if (isServer) then {
  civilian setFriend [east, 1];
  
  [] call CreatePlayzoneBoundaries;
  [] call CreatePlayerBases;
  [] call CreatePlayerInventory;

  [180] spawn FoodSupplyLoop;
  [90] spawn WeaponSupplyLoop;
};
