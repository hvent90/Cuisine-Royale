CreatePlayzoneBoundaries = {
  _max = 140;
  _playzoneSize = (triggerArea playzone) select 0;

  for [{_i = 0}, {_i < _max}, {_i = _i + 1}] do {
    _pos = playzone getPos [_playzoneSize, _i / _max * 360];
    _wall = createSimpleObject ["Land_Net_FenceD_8m_F", AGLtoASL _pos];
    _wall setDir (_wall getRelDir playzone);
  };
};
