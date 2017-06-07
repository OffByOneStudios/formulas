

var evaluate = require('../src/index').default;

const s = new Date();
const res = new Array(10);

f = evaluate("30 / (x + 2)")

for(let i = 0; i< 1000; i++)
{
  res[i] = f(i);
}
const e = new Date();

console.log(`Time:${e.getTime() - s.getTime()}`);

console.log(f.raw)