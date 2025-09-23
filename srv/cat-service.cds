using { pocap.db.master as master, pocap.db.transaction as transaction } from '../db/datamodel';
using { pocap.common as common  } from '../db/common';

service CatalogService @(path: 'CatalogService' , requires: 'authenticated-user') {

  @Capabilities: {
    InsertRestrictions: { $Type: 'Capabilities.InsertRestrictionsType' },
    UpdateRestrictions: { $Type: 'Capabilities.UpdateRestrictionsType' },
    DeleteRestrictions: { $Type: 'Capabilities.DeleteRestrictionsType' }
  }

  entity businesspartner   as projection on master.businesspartner;
  entity ProductInformation as projection on master.product;
  entity EmployeeDetails @(restrict:[
    {
      grant : ['READ'], to : 'Viewer', where : 'bankName = $user.bankName'
    },
    {
      grant : ['WRITE'], to : 'Admin'
    }
  ])   as projection on master.employees;
  entity AddressInfo  @(restrict : [
    {
      grant : ['READ'], to : 'Viewer', where : 'COUNTRY = #user.myCountry'
    },
    {
      grant : ['WRITE'], to : 'Admin'
    }
  ])      as projection on master.address;

  entity PODetails @(
    odata.draft.enabled : true
  ) as projection on transaction.purchaseorder {
    *,
    case OVERALL_STATUS
    when 'N' then 'New'
    when 'P' then 'Paid'
    when 'B' then 'Blocked'
    when 'R' then 'Returned'
    else 'Delivered'
    end as OverallStatus : String(20) @(title: '{i18n>OVERALL_STATUS}'),
    case OVERALL_STATUS
    when 'N' then 1
    when 'P' then 2
    when 'B' then 1
    when 'R' then 1
    else 3
    end as OSCriticality : Integer,
     case LIFECYCLE_STATUS
    when 'N' then 'New'
    when 'I' then 'In Progress'
    when 'P' then 'Pending'
    when 'C' then 'Cancelled'
    else 'Done'
    end as LifecycleStatus : String(20) @(title: '{i18n>LIFECYCLE_STATUS}'),
     case LIFECYCLE_STATUS
   when 'N' then 1
    when 'I' then 2
    when 'P' then 1
    when 'C' then 3
    else 2
    end as LSCriticality : Integer,
    Items: redirected to POItems 
  
}
  // Bound operations — declare outside the projection list'
  actions {
    @cds.odata.bindingparameter.name : '_pricehike'
    @Common.SideEffects : {
      TargetProperties : [
        '_pricehike/GROSS_AMOUNT',
        '_pricehike/NET_AMOUNT'
      ],
    }
    action increasedPrice() returns array of  PODetails;
    function largestOrder() returns array of  PODetails;
  };
  
  entity POItems as projection on transaction.purchaseitems;
  entity student as projection on master.student;

  action createEmployee(
        nameFirst : String(40),
        nameMiddle : String(40),
        nameLast : String(40),
        nameInitials : String(40),
        gender : common.Gender,
        language : String(2),
        phone : common.phoneNumber,
        email : common.Email,
        loginName : String(15),
        salaryAmount : common.AmountT,
        accountNumber : String(16),
        bankId : String(12),
        bankName : String(64),
  )
  returns array of String;

  function getProducts(CURRENCY_CODE : String(3)) returns ProductInformation;
}



