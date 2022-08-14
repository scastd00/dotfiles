module.exports = {
  extends: "stylelint-config-standard",
  rules: {
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
