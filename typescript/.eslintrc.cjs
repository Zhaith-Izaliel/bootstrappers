const path = require("node:path");

module.exports = {
  root: true,
  env: {
    node: true,
    commonjs: true,
    es2021: true,
  },
  extends: [
    "plugin:jsdoc/recommended-typescript-error",
    "plugin:import/typescript",
    "airbnb-base",
    "airbnb-typescript/base",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    ecmaVersion: "latest",
    sourceType: "module",
    project: path.join(__dirname, "tsconfig.json"),
  },
  settings: {
    "import/resolver": {
      typescript: true,
      node: true,
    },
  },
  plugins: ["@typescript-eslint", "jsdoc", "@stylistic/eslint-plugin-js"],
  rules: {
    "no-constant-binary-expression": "warn",
    "@stylistic/js/eol-last": ["error", "always"],
    "@stylistic/js/brace-style": ["error", "1tbs", { allowSingleLine: true }],
    "@stylistic/js/array-element-newline": [
      "error",
      { multiline: true, minItems: 3 },
    ],
    "@stylistic/js/array-bracket-spacing": ["error", "always"],
    "no-constructor-return": "error",
    "no-duplicate-imports": "error",
    "no-template-curly-in-string": "error",
    "no-self-compare": "warn",
    "require-atomic-updates": "error",
    "default-case": "error",
    curly: "error",
    "max-depth": ["error", 3],
    "dot-notation": "error",
    "no-console":
      process.env.NODE_ENV === "production"
        ? ["error", { allow: ["warn", "error"] }]
        : "off",
    "new-cap": "error",
    "no-else-return": ["error", { allowElseIf: false }],
    "sort-imports": [
      "warn",
      {
        ignoreCase: false,
        ignoreDeclarationSort: false,
        ignoreMemberSort: false,
        memberSyntaxSortOrder: ["none", "all", "multiple", "single"],
        allowSeparatedGroups: false,
      },
    ],
    "@typescript-eslint/naming-convention": [
      "error",
      {
        selector: "variable",
        format: ["camelCase", "PascalCase", "UPPER_CASE"],
      },
      {
        selector: "function",
        format: ["camelCase", "PascalCase"],
      },
      {
        selector: "typeLike",
        format: ["PascalCase"],
      },
    ],
    eqeqeq: "error",
    indent: ["error", 2],
    "linebreak-style": ["error", "unix"],
    quotes: ["error", "single"],
    semi: ["error", "always"],
  },
};

