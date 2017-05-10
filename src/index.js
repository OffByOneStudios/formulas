
var parser = require('../peg/parser.js');

function evaluate(formula) {
  // TODO check for only 1 variable
  var formula_struct = parser.parse(formula.replace(/[a-zA-Z]+/, 'x'))
  const res = (val) => {
    if (this.isInv)
    {
      val *= this.ia;
      val += this.ic;
      val = 1/val;
    }
    val *= this.a;
    val += this.c;
    return val;
  };
  return res.bind(formula_struct);
}
exports.default = evaluate
