___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Hero Ecommerce Tracking",
  "categories": ["ATTRIBUTION"],
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "eventType",
    "displayName": "Event Type",
    "selectItems": [
      {
        "value": "detail",
        "displayValue": "Product View"
      },
      {
        "value": "add",
        "displayValue": "Add to Cart"
      },
      {
        "value": "remove",
        "displayValue": "Remove from Cart"
      },
      {
        "value": "purchase",
        "displayValue": "Purchase"
      },
      {
        "value": "category",
        "displayValue": "Category View"
      },
      {
        "value": "search",
        "displayValue": "Search"
      }
    ],
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "defaultValue": "detail"
  },
  {
    "type": "TEXT",
    "name": "idParameter",
    "displayName": "Purchase ID (Required)",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "purchase",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Purchase/order id"
  },
  {
    "type": "TEXT",
    "name": "currencyParameter",
    "displayName": "Purchase currency (Required)",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "purchase",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "^[A-Z]{3}$"
        ]
      }
    ],
    "valueHint": "USD",
    "help": "Purchase currency (matching the ISO 4217 standard)"
  },
  {
    "type": "TEXT",
    "name": "subtotalParameter",
    "displayName": "Purchase subtotal (Required)",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "purchase",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "NUMBER"
      }
    ],
    "help": "The total value for every product in your purchase"
  },
  {
    "type": "TEXT",
    "name": "totalParameter",
    "displayName": "Purchase total",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "purchase",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "NUMBER"
      }
    ],
    "help": "The overall adjusted total calculated value for every product in your purchase"
  },
  {
    "type": "TEXT",
    "name": "taxParameter",
    "displayName": "Purchase tax",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "purchase",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NUMBER"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "shippingParameter",
    "displayName": "Purchase shipping",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "purchase",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NUMBER"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "categoryParameter",
    "displayName": "Category value (Required)",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "category",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "searchParameter",
    "displayName": "Search value (Required)",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "search",
        "type": "EQUALS"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "products",
    "displayName": "Product Object (Required)",
    "simpleValueType": true,
    "valueHint": "Product object / array variable",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "eventType",
        "paramValue": "detail",
        "type": "EQUALS"
      },
      {
        "paramName": "eventType",
        "paramValue": "add",
        "type": "EQUALS"
      },
      {
        "paramName": "eventType",
        "paramValue": "remove",
        "type": "EQUALS"
      },
      {
        "paramName": "eventType",
        "paramValue": "purchase",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const callInWindow = require('callInWindow');
const copyFromWindow = require('copyFromWindow');
const log = require('logToConsole');
const setInWindow = require('setInWindow');

const heroClientAPI = copyFromWindow('hero');

if (heroClientAPI === undefined) {
  const queue = function(params) {
    callInWindow('hero.q.push', params);
  };

  setInWindow('HeroObject', 'hero');

  setInWindow('hero', function(params) {
    queue(arguments);
  });

  setInWindow('hero.q', []);
}

const products = data.products;
const eventType = data.eventType;

const trackObject = (function() {
  switch (eventType) {
    case 'detail':
      return {
        type: "ecommerce:detail",
        products: products
      };
    case 'add':
      return {
        type: "ecommerce:add",
        products: products
      };
    case 'remove':
      return {
        type: "ecommerce:remove",
        products: products
      };
    case 'purchase':
      return {
        type: "ecommerce:purchase",
        purchase: {
          id: data.idParameter,
          total: data.totalParameter,
          subtotal: data.subtotalParameter,
          tax: data.taxParameter,
          shipping: data.shippingParameter,
          currency: data.currencyParameter
        },
        products: products
      };
    default:
      break;
  }
})();

log('data:', trackObject);

if (trackObject) {
  callInWindow('hero', 'track', trackObject);
}

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "hero"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "hero.q"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "hero.q.push"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "HeroObject"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 27/03/2020, 11:11:48


