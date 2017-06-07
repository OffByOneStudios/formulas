
var parser = require('../peg/parser.js');

function evaluator(argument) {
  var val = argument;
  if (this.isInv)
  {
    val *= this.ia;
    val += this.ic;
    val = 1/val;
  }
  val *= this.a;
  val += this.c;
  return val;
}

function evaluate(formula) {
  // TODO check for only 1 variable
  var formula_struct = parser.parse(formula.replace(/[a-zA-Z]+/, 'x'))
  let res =  evaluator.bind(formula_struct);
  Object.defineProperty(res, 'formula', {value: () => { return formula_struct}})
  res.raw = formula;
  return res;
}
exports.default = evaluate
