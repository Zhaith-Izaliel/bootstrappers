const path = require("node:path");

module.exports = {
  root: true,
  env: {
    node: true,
    browser: true,
    commonjs: true,
    es2021: true,
  },
  extends: [
    "plugin:jsdoc/recommended-typescript-error",
    "plugin:vue/vue3-recommended",
    "airbnb-base",
    "airbnb-typescript/base",
    "plugin:import/typescript",
    "plugin:storybook/recommended",
    "prettier",
  ],
  parser: "vue-eslint-parser",
  parserOptions: {
    ecmaVersion: "latest",
    parser: "@typescript-eslint/parser",
    extraFileExtensions: ["vue"],
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
    "no-constructor-return": "error",
    "no-duplicate-imports": "error",
    "no-template-curly-in-string": "error",
    "no-self-compare": "warn",
    "require-atomic-updates": "error",
    "default-case": "error",
    curly: "error",
    "dot-notation": "error",
    "no-console":
      process.env.NODE_ENV === "production"
        ? ["error", { allow: ["warn", "error"] }]
        : "off",
    "new-cap": "error",
    "no-else-return": ["error", { allowElseIf: false }],
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
    indent: ["error", 2, { SwitchCase: 1 }],
    "linebreak-style": ["error", "unix"],
    quotes: ["error", "single", { avoidEscape: true }],
    semi: ["error", "always"],
    "vue/multi-word-component-names": "off",
  },
  overrides: [
    {
      files: ["src/**/*.vue"],
      rules: {
        "max-len": "off",
      },
    },
  ],
};
