
var parser = require('../peg/parser.js');

function evaluate(formula) {
  // TODO check for only 1 variable
  var formula_struct = parser.parse(formula.replace(/[a-zA-Z]+/, 'x'))
  const evaluate = (val) => {
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
  let res =  evaluate.bind(formula_struct);
  Object.defineProperty(res, 'formula', {value: () => { return formula_struct}})
  return res;
}
exports.default = evaluate
