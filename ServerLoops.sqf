FoodSupplyLoop = {
  _time = _this select 0;

  while {true} do {
      [] call InitFoodSupply;
      sleep _time;
  };
};

WeaponSupplyLoop = {
  _time = _this select 0;

  while {true} do {
    [] call InitWeaponSupply;
    sleep _time;
  };
};
