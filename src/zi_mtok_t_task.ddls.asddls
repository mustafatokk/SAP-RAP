@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite: Task'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZI_MTOK_T_TASK as select from ZR_MTOK_T_TASK
composition [0..*] of ZI_MTOK_T_SUBTASK as _subtask
{
    key TaskID ,
    Title,
    Description,
    Status,
    StatusCriticality,
    Priority,
    DueDate,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    _subtask // Make association public
}
