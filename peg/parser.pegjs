/*
 * Simple Arithmetics Grammar
 * ==========================
 *
 * Accepts expressions like "2 * (3 + 4)" and computes their value.
 */

Expression
  = head:Term tail:(_ ("+" / "-") _ Term)* {
  	  var calc = head;
      if (typeof(head) == 'object')
      	calc = head['c'];

      var found = false
      for (var i = 0; i < tail.length; i++) {
      	var obj = tail[i][3];
        if (typeof(obj) == 'object') {
          found = obj
          if (tail[i][1] === "-") obj['a'] = -obj['a']
          obj = obj['c']
        }
        if (tail[i][1] === "+") { calc += obj; }
        if (tail[i][1] === "-") { calc -= obj; }
      }

      var result = calc;
      if (typeof(found) == 'object') {
        found['c'] = calc;
        result = found;
      }
      if (typeof(head) == 'object') {
      	head['c'] = calc;
        result = head
      }

      return result;
    }

Term
  = head:Factor tail:(_ ("*" / "/") _ Factor)* {
  	  var calc = head;

      for (var i = 0; i < tail.length; i++) {
      	var obj = tail[i][3];
        if (typeof(calc) == 'object') {
          if (tail[i][1] === "*") { calc['a'] *= obj; calc['c'] *= obj; }
          if (tail[i][1] === "/") { calc['a'] /= obj; calc['c'] /= obj; }
        } else if (typeof(obj) == 'object') {
          if (tail[i][1] === "*") { obj['a'] *= calc; obj['c'] *= calc; }
          if (tail[i][1] === "/") {
          	obj['isInv'] = true;
            obj['ia'] = obj['a']
            obj['ic'] = obj['c']
            obj['a'] = calc
            obj['c'] = 0
          }
          calc = obj
        } else {
          if (tail[i][1] === "*") { calc *= obj; }
          if (tail[i][1] === "/") { calc /= obj; }
        }
      }

      return calc;
    }

Factor
  = "(" _ expr:Expression _ ")" { return expr; }
  / Float
  / Var

Var
  = [x] { return { c: 0.0, a: 1.0, isInv: false }; }

Float "float"
  = [+-]?([0-9]*[.])?[0-9]+ { return parseFloat(text()); }

_ "whitespace"
  = [ \t\n\r]*
