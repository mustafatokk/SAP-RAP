@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZMTOK_T_TASK'
}
@AccessControl.authorizationCheck:#NOT_REQUIRED
define root view entity ZC_MTOK_T_TASK
  provider contract transactional_query
  as projection on ZI_MTOK_T_TASK
  //association [1..1] to ZR_MTOK_T_TASK as _BaseEntity on $projection.TaskID = _BaseEntity.TaskID
{
  key TaskID,
      Title,
      Description,

     
      Status,      
      StatusCriticality,
      Priority,
      DueDate,
      @Semantics: {
        user.createdBy: true
      }
      CreatedBy,
      @Semantics: {
        systemDateTime.createdAt: true
      }
      CreatedAt,
      @Semantics: {
        user.lastChangedBy: true
      }
      LastChangedBy,
      @Semantics: {
        systemDateTime.lastChangedAt: true
      }
      LastChangedAt,
      @Semantics: {
        systemDateTime.localInstanceLastChangedAt: true
      }
      LocalLastChangedAt,
      _subtask : redirected to composition child ZC_MTOK_T_SUBTASK
}
