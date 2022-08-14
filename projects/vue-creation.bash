#!/bin/bash

echo 'What is the name of the project?'
read -r project

vue create "$project"
cd "$project" || exit
npm install eslint stylelint stylelint-config-standard -D

echo 'Generating eslintrc and stylelintrc files...'

echo '{
  "root": true,
  "env": {
    "browser": true,
    "node": true
  },
  "extends": ["plugin:vue/essential", "eslint:recommended"],
  "parserOptions": {
    "ecmaVersion": 12,
    "sourceType": "module",
    "parser": "babel-eslint"
  },
  "plugins": ["vue"],
  "rules": {
    "indent": ["error", 2],
    "semi": ["error", "always"],
    "quotes": ["warn", "single",
      {
        "avoidEscape": true,
        "allowTemplateLiterals": true
      }
    ],
    "space-before-function-paren": ["error", "never"],
    "space-in-parens": ["error", "never"],
    "max-len": ["error", {
      "code": 100,
      "comments": 70
    }],
    "multiline-ternary": ["error", "never"],
    "eol-last": ["error", "always"],
    "no-trailing-spaces": "error",
    "no-multiple-empty-lines": ["error", {
      "max": 2,
      "maxEOF": 0
    }],
    "vue/html-indent": ["error", 2, {
      "attribute": 1,
      "baseIndent": 1,
      "closeBracket": 0,
      "switchCase": 0,
      "alignAttributesVertically": true
    }],
    "vue/attributes-order": ["error", {
      "order": [
        "DEFINITION",
        "LIST_RENDERING",
        "CONDITIONALS",
        "RENDER_MODIFIERS",
        "GLOBAL",
        ["UNIQUE", "SLOT"],
        "TWO_WAY_BINDING",
        "OTHER_DIRECTIVES",
        "OTHER_ATTR",
        "EVENTS",
        "CONTENT"
      ],
      "alphabetical": false
    }],
    "vue/component-tags-order": ["error", {
      "order": ["template", "script", "style"]
    }],
    "vue/component-name-in-template-casing": ["error", "PascalCase"],
    "vue/singleline-html-element-content-newline": "error",
    "vue/multiline-html-element-content-newline": "error"
  }
}
' > .eslintrc.json

echo '{
  "extends": "stylelint-config-standard",
  "rules": {
    "block-no-empty": [
      true,
      {
        "ignore": [
          "comments"
        ]
      }
    ],
    "comment-no-empty": true,
    "indentation": 2,
    "comment-whitespace-inside": "never"
  }
}
' > .stylelintrc.json
