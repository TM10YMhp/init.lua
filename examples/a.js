// js
const js = `console.log("a")`;
const js = `
// javascript
console.log("a");
`;
const js = /* js */ `console.log("a")`;
console.log(/* js */ `console.log("a")`);

// ts
const ts = `type T = {}`;
const ts = `
// ts
type T = {};
`;
const ts = /* ts */ `type T = {}`;
console.log(/* ts */ `type T = {}`);

// sql
const sql = `
INSERT INTO bar (name, age) VALUES (
  'qwe', 10
);
`;
const sql = `
-- sql
SELECT * FROM foo
`;
const sql = /* sql */ `SELECT * FROM foo`;
console.log(/* sql */ `SELECT * FROM foo`);

// css
const css = `p { font-size: 10px; }`;
const css = `
/* css */
p { font-size: 10px; }
`;
const b = /* css */ `p { font-size: 10px; }`;
console.log(/* css */ `p { font-size: 10px; }`);

// py
const py = `print("hello")`;
const py = `
# py
print("hello")
`;
const py = /* py */ `print("hello")`;
console.log(/* py */ `print("hello")`);

// html
const html = `<p>paragraph</p>`;
const html = `
<!-- html -->
<p>paragraph</p>
`;
const html = /* html */ `<p>paragraph</p>`;
console.log(/* html */ `<p>paragraph</p>`);

const nested = `
<!-- html -->
<html>
  <body>
    <header
      id="nav"
      :class="headerClassName()"
      x-init="console.log('Im being initialized!')"
      x-data="{
        a: 1,
        b: 2,
        c: function() {
          console.log('c');
        }
      }"
    ></header>
    <div x-bind:style="true && { color: 'red' }"></div>

    <!-- Will render: -->
    <div
      style="color: red"
      x-data="{
        username: '<!-- html --> <strong>calebporzio</strong>',
      }"
    >
      <template x-for="(_, asd) in colors">
        <li x-text="color"></li>
      </template>
    </div>
  </body>
</html>
`;
