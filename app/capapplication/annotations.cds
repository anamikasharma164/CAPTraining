using CatalogService as service from '../../srv/cat-service';
 
annotate CatalogService.PODetails with @(
    // This annotation used to select all fields
    UI.SelectionFields : [
        PO_ID,                                          // Purchase Order ID
        PARTNER_GUID.COMPNAY_NAME,                      // Company Name
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,              // Country
        GROSS_AMOUNT                                    // Gross Amount
    ],

 
 
 
 // This annotation for the table and related data
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ID
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPNAY_NAME
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.BP_ID
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Increased Price',
            Action : 'CatalogService.increasedPrice',
            Inline : true
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        },

        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY
        },
        {
            $Type : 'UI.DataField',
            Value : LifecycleStatus,
            Criticality : LSCriticality
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality : OSCriticality
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Order',
        TypeNamePlural : 'PUrchase Orders',
        Title : {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPNAY_NAME
        },
        TypeImageUrl : 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/PwC_2025_Logo.svg/120px-PwC_2025_Logo.svg.png?20250429090744'
    },

     UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Purchase Order Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Details',
                    Target : '@UI.FieldGroup#MoreInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Price Details',
                    Target : '@UI.FieldGroup#PriceInfo'
                },
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase items',
            Target : 'Items/@UI.LineItem'
        }
    ],
 
    UI.FieldGroup #MoreInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID_NODE_KEY
            },
            {
                $Type : 'UI.DataField',
                Value : OverallStatus,
                Criticality : OSCriticality
            },
            {
                $Type : 'UI.DataField',
                Value : LifecycleStatus,
                Criticality : LSCriticality
            }
        ]
    },
 
    UI.FieldGroup #PriceInfo: {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            }
        ]
    }
);
 
annotate CatalogService.POItems with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEMS_POS
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.DESCRIPTION
 
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase item',
        TypeNamePlural : 'Purchase items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEMS_POS,
        }
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Purhcase item details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Purchase item data',
                    Target : '@UI.FieldGroup#ItemData'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product information',
                    Target : '@UI.FieldGroup#ProductData'
                }
            ],
        },
    ],
 
    UI.FieldGroup #ItemData : {
        Label : 'Purchase item  data',
        Data : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEMS_POS
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.DESCRIPTION
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        },
        ],
    },
 
    UI.FieldGroup #ProductData : {
        Label : 'Product Information',
        Data : [
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.CATEGORY
        },
        {
            $Type : 'UI.DataField',
            Value :PRODUCT_GUID.PRICE
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.WIDTH
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.DEPTH
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.HEIGHT
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.SUPPLIER_GUID.COMPNAY_NAME
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.SUPPLIER_GUID.ADDRESS_GUID.COUNTRY
        },
        ],
    },
);