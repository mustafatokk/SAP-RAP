@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZMTOK_T_TASK'
@EndUserText.label: 'Task Base View'
define root view entity ZR_MTOK_T_TASK
  as select from zmtok_t_task

{
  key task_id               as TaskID,
      title                 as Title,
      description           as Description,
      status                as Status,
      case status
      when 'OPEN' then 1
      when 'WORKING' then 2
      when 'DONE' then 3
      else 0 end            as StatusCriticality,
      priority              as Priority,
      due_date              as DueDate,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt

}
