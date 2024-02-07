/* @flow */
/* eslint-disable */
//  This file was automatically generated and should not be edited.

export type CreatePatientInput = {|
  ssn: string,
  givenName: string,
  familyName: string,
|};

export type ModelPatientConditionInput = {|
  and?: ?Array< ?ModelPatientConditionInput >,
  or?: ?Array< ?ModelPatientConditionInput >,
  not?: ?ModelPatientConditionInput,
  createdAt?: ?ModelStringInput,
  updatedAt?: ?ModelStringInput,
|};

export type ModelStringInput = {|
  ne?: ?string,
  eq?: ?string,
  le?: ?string,
  lt?: ?string,
  ge?: ?string,
  gt?: ?string,
  contains?: ?string,
  notContains?: ?string,
  between?: ?Array< ?string >,
  beginsWith?: ?string,
  attributeExists?: ?boolean,
  attributeType?: ?ModelAttributeTypes,
  size?: ?ModelSizeInput,
|};

export type ModelAttributeTypes =
  "binary" |
  "binarySet" |
  "bool" |
  "list" |
  "map" |
  "number" |
  "numberSet" |
  "string" |
  "stringSet" |
  "_null";


export type ModelSizeInput = {|
  ne?: ?number,
  eq?: ?number,
  le?: ?number,
  lt?: ?number,
  ge?: ?number,
  gt?: ?number,
  between?: ?Array< ?number >,
|};

export type UpdatePatientInput = {|
  ssn: string,
  givenName: string,
  familyName: string,
|};

export type DeletePatientInput = {|
  ssn: string,
  givenName: string,
  familyName: string,
|};

export type CreateMedicalAppointmentInput = {|
  appointmentReference: string,
  provider?: ?string,
  date?: ?any,
  medicalAppointmentPatientSsn?: ?string,
  medicalAppointmentPatientGivenName?: ?string,
  medicalAppointmentPatientFamilyName?: ?string,
|};

export type ModelMedicalAppointmentConditionInput = {|
  provider?: ?ModelStringInput,
  date?: ?ModelStringInput,
  and?: ?Array< ?ModelMedicalAppointmentConditionInput >,
  or?: ?Array< ?ModelMedicalAppointmentConditionInput >,
  not?: ?ModelMedicalAppointmentConditionInput,
  createdAt?: ?ModelStringInput,
  updatedAt?: ?ModelStringInput,
  medicalAppointmentPatientSsn?: ?ModelIDInput,
  medicalAppointmentPatientGivenName?: ?ModelStringInput,
  medicalAppointmentPatientFamilyName?: ?ModelStringInput,
|};

export type ModelIDInput = {|
  ne?: ?string,
  eq?: ?string,
  le?: ?string,
  lt?: ?string,
  ge?: ?string,
  gt?: ?string,
  contains?: ?string,
  notContains?: ?string,
  between?: ?Array< ?string >,
  beginsWith?: ?string,
  attributeExists?: ?boolean,
  attributeType?: ?ModelAttributeTypes,
  size?: ?ModelSizeInput,
|};

export type UpdateMedicalAppointmentInput = {|
  appointmentReference: string,
  provider?: ?string,
  date?: ?any,
  medicalAppointmentPatientSsn?: ?string,
  medicalAppointmentPatientGivenName?: ?string,
  medicalAppointmentPatientFamilyName?: ?string,
|};

export type DeleteMedicalAppointmentInput = {|
  appointmentReference: string,
|};

export type CreateTodoInput = {|
  content?: ?string,
  id?: ?string,
|};

export type ModelTodoConditionInput = {|
  content?: ?ModelStringInput,
  and?: ?Array< ?ModelTodoConditionInput >,
  or?: ?Array< ?ModelTodoConditionInput >,
  not?: ?ModelTodoConditionInput,
  createdAt?: ?ModelStringInput,
  updatedAt?: ?ModelStringInput,
  owner?: ?ModelStringInput,
|};

export type UpdateTodoInput = {|
  content?: ?string,
  id: string,
|};

export type DeleteTodoInput = {|
  id: string,
|};

export type ModelPatientPrimaryCompositeKeyConditionInput = {|
  eq?: ?ModelPatientPrimaryCompositeKeyInput,
  le?: ?ModelPatientPrimaryCompositeKeyInput,
  lt?: ?ModelPatientPrimaryCompositeKeyInput,
  ge?: ?ModelPatientPrimaryCompositeKeyInput,
  gt?: ?ModelPatientPrimaryCompositeKeyInput,
  between?: ?Array< ?ModelPatientPrimaryCompositeKeyInput >,
  beginsWith?: ?ModelPatientPrimaryCompositeKeyInput,
|};

export type ModelPatientPrimaryCompositeKeyInput = {|
  givenName?: ?string,
  familyName?: ?string,
|};

export type ModelPatientFilterInput = {|
  ssn?: ?ModelIDInput,
  givenName?: ?ModelStringInput,
  familyName?: ?ModelStringInput,
  and?: ?Array< ?ModelPatientFilterInput >,
  or?: ?Array< ?ModelPatientFilterInput >,
  not?: ?ModelPatientFilterInput,
  createdAt?: ?ModelStringInput,
  updatedAt?: ?ModelStringInput,
|};

export type ModelSortDirection =
  "ASC" |
  "DESC";


export type ModelMedicalAppointmentFilterInput = {|
  appointmentReference?: ?ModelIDInput,
  provider?: ?ModelStringInput,
  date?: ?ModelStringInput,
  and?: ?Array< ?ModelMedicalAppointmentFilterInput >,
  or?: ?Array< ?ModelMedicalAppointmentFilterInput >,
  not?: ?ModelMedicalAppointmentFilterInput,
  createdAt?: ?ModelStringInput,
  updatedAt?: ?ModelStringInput,
  medicalAppointmentPatientSsn?: ?ModelIDInput,
  medicalAppointmentPatientGivenName?: ?ModelStringInput,
  medicalAppointmentPatientFamilyName?: ?ModelStringInput,
|};

export type ModelTodoFilterInput = {|
  content?: ?ModelStringInput,
  and?: ?Array< ?ModelTodoFilterInput >,
  or?: ?Array< ?ModelTodoFilterInput >,
  not?: ?ModelTodoFilterInput,
  createdAt?: ?ModelStringInput,
  updatedAt?: ?ModelStringInput,
  owner?: ?ModelStringInput,
|};

export type ModelSubscriptionPatientFilterInput = {|
  ssn?: ?ModelSubscriptionIDInput,
  givenName?: ?ModelSubscriptionStringInput,
  familyName?: ?ModelSubscriptionStringInput,
  and?: ?Array< ?ModelSubscriptionPatientFilterInput >,
  or?: ?Array< ?ModelSubscriptionPatientFilterInput >,
  createdAt?: ?ModelSubscriptionStringInput,
  updatedAt?: ?ModelSubscriptionStringInput,
|};

export type ModelSubscriptionIDInput = {|
  ne?: ?string,
  eq?: ?string,
  le?: ?string,
  lt?: ?string,
  ge?: ?string,
  gt?: ?string,
  contains?: ?string,
  notContains?: ?string,
  between?: ?Array< ?string >,
  beginsWith?: ?string,
  in?: ?Array< ?string >,
  notIn?: ?Array< ?string >,
|};

export type ModelSubscriptionStringInput = {|
  ne?: ?string,
  eq?: ?string,
  le?: ?string,
  lt?: ?string,
  ge?: ?string,
  gt?: ?string,
  contains?: ?string,
  notContains?: ?string,
  between?: ?Array< ?string >,
  beginsWith?: ?string,
  in?: ?Array< ?string >,
  notIn?: ?Array< ?string >,
|};

export type ModelSubscriptionMedicalAppointmentFilterInput = {|
  appointmentReference?: ?ModelSubscriptionIDInput,
  provider?: ?ModelSubscriptionStringInput,
  date?: ?ModelSubscriptionStringInput,
  and?: ?Array< ?ModelSubscriptionMedicalAppointmentFilterInput >,
  or?: ?Array< ?ModelSubscriptionMedicalAppointmentFilterInput >,
  createdAt?: ?ModelSubscriptionStringInput,
  updatedAt?: ?ModelSubscriptionStringInput,
  medicalAppointmentPatientSsn?: ?ModelIDInput,
  medicalAppointmentPatientGivenName?: ?ModelStringInput,
  medicalAppointmentPatientFamilyName?: ?ModelStringInput,
|};

export type ModelSubscriptionTodoFilterInput = {|
  content?: ?ModelSubscriptionStringInput,
  and?: ?Array< ?ModelSubscriptionTodoFilterInput >,
  or?: ?Array< ?ModelSubscriptionTodoFilterInput >,
  createdAt?: ?ModelSubscriptionStringInput,
  updatedAt?: ?ModelSubscriptionStringInput,
  owner?: ?ModelStringInput,
|};

export type CreatePatientMutationVariables = {|
  input: CreatePatientInput,
  condition?: ?ModelPatientConditionInput,
|};

export type CreatePatientMutation = {|
  createPatient: ? {|
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: any,
    updatedAt: any,
  |},
|};

export type UpdatePatientMutationVariables = {|
  input: UpdatePatientInput,
  condition?: ?ModelPatientConditionInput,
|};

export type UpdatePatientMutation = {|
  updatePatient: ? {|
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: any,
    updatedAt: any,
  |},
|};

export type DeletePatientMutationVariables = {|
  input: DeletePatientInput,
  condition?: ?ModelPatientConditionInput,
|};

export type DeletePatientMutation = {|
  deletePatient: ? {|
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: any,
    updatedAt: any,
  |},
|};

export type CreateMedicalAppointmentMutationVariables = {|
  input: CreateMedicalAppointmentInput,
  condition?: ?ModelMedicalAppointmentConditionInput,
|};

export type CreateMedicalAppointmentMutation = {|
  createMedicalAppointment: ? {|
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient: ? {|
      __typename: string,
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: any,
      updatedAt: any,
    |},
    provider: ?string,
    date: ?any,
    createdAt: any,
    updatedAt: any,
    medicalAppointmentPatientSsn: ?string,
    medicalAppointmentPatientGivenName: ?string,
    medicalAppointmentPatientFamilyName: ?string,
  |},
|};

export type UpdateMedicalAppointmentMutationVariables = {|
  input: UpdateMedicalAppointmentInput,
  condition?: ?ModelMedicalAppointmentConditionInput,
|};

export type UpdateMedicalAppointmentMutation = {|
  updateMedicalAppointment: ? {|
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient: ? {|
      __typename: string,
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: any,
      updatedAt: any,
    |},
    provider: ?string,
    date: ?any,
    createdAt: any,
    updatedAt: any,
    medicalAppointmentPatientSsn: ?string,
    medicalAppointmentPatientGivenName: ?string,
    medicalAppointmentPatientFamilyName: ?string,
  |},
|};

export type DeleteMedicalAppointmentMutationVariables = {|
  input: DeleteMedicalAppointmentInput,
  condition?: ?ModelMedicalAppointmentConditionInput,
|};

export type DeleteMedicalAppointmentMutation = {|
  deleteMedicalAppointment: ? {|
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient: ? {|
      __typename: string,
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: any,
      updatedAt: any,
    |},
    provider: ?string,
    date: ?any,
    createdAt: any,
    updatedAt: any,
    medicalAppointmentPatientSsn: ?string,
    medicalAppointmentPatientGivenName: ?string,
    medicalAppointmentPatientFamilyName: ?string,
  |},
|};

export type CreateTodoMutationVariables = {|
  input: CreateTodoInput,
  condition?: ?ModelTodoConditionInput,
|};

export type CreateTodoMutation = {|
  createTodo: ? {|
    __typename: "Todo",
    content: ?string,
    id: string,
    createdAt: any,
    updatedAt: any,
    owner: ?string,
  |},
|};

export type UpdateTodoMutationVariables = {|
  input: UpdateTodoInput,
  condition?: ?ModelTodoConditionInput,
|};

export type UpdateTodoMutation = {|
  updateTodo: ? {|
    __typename: "Todo",
    content: ?string,
    id: string,
    createdAt: any,
    updatedAt: any,
    owner: ?string,
  |},
|};

export type DeleteTodoMutationVariables = {|
  input: DeleteTodoInput,
  condition?: ?ModelTodoConditionInput,
|};

export type DeleteTodoMutation = {|
  deleteTodo: ? {|
    __typename: "Todo",
    content: ?string,
    id: string,
    createdAt: any,
    updatedAt: any,
    owner: ?string,
  |},
|};

export type GetPatientQueryVariables = {|
  ssn: string,
  givenName: string,
  familyName: string,
|};

export type GetPatientQuery = {|
  getPatient: ? {|
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: any,
    updatedAt: any,
  |},
|};

export type ListPatientsQueryVariables = {|
  ssn?: ?string,
  givenNameFamilyName?: ?ModelPatientPrimaryCompositeKeyConditionInput,
  filter?: ?ModelPatientFilterInput,
  limit?: ?number,
  nextToken?: ?string,
  sortDirection?: ?ModelSortDirection,
|};

export type ListPatientsQuery = {|
  listPatients: ? {|
    __typename: "ModelPatientConnection",
    items:  Array<? {|
      __typename: string,
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: any,
      updatedAt: any,
    |} >,
    nextToken: ?string,
  |},
|};

export type GetMedicalAppointmentQueryVariables = {|
  appointmentReference: string,
|};

export type GetMedicalAppointmentQuery = {|
  getMedicalAppointment: ? {|
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient: ? {|
      __typename: string,
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: any,
      updatedAt: any,
    |},
    provider: ?string,
    date: ?any,
    createdAt: any,
    updatedAt: any,
    medicalAppointmentPatientSsn: ?string,
    medicalAppointmentPatientGivenName: ?string,
    medicalAppointmentPatientFamilyName: ?string,
  |},
|};

export type ListMedicalAppointmentsQueryVariables = {|
  appointmentReference?: ?string,
  filter?: ?ModelMedicalAppointmentFilterInput,
  limit?: ?number,
  nextToken?: ?string,
  sortDirection?: ?ModelSortDirection,
|};

export type ListMedicalAppointmentsQuery = {|
  listMedicalAppointments: ? {|
    __typename: "ModelMedicalAppointmentConnection",
    items:  Array<? {|
      __typename: string,
      appointmentReference: string,
      provider: ?string,
      date: ?any,
      createdAt: any,
      updatedAt: any,
      medicalAppointmentPatientSsn: ?string,
      medicalAppointmentPatientGivenName: ?string,
      medicalAppointmentPatientFamilyName: ?string,
    |} >,
    nextToken: ?string,
  |},
|};

export type GetTodoQueryVariables = {|
  id: string,
|};

export type GetTodoQuery = {|
  getTodo: ? {|
    __typename: "Todo",
    content: ?string,
    id: string,
    createdAt: any,
    updatedAt: any,
    owner: ?string,
  |},
|};

export type ListTodosQueryVariables = {|
  filter?: ?ModelTodoFilterInput,
  limit?: ?number,
  nextToken?: ?string,
|};

export type ListTodosQuery = {|
  listTodos: ? {|
    __typename: "ModelTodoConnection",
    items:  Array<? {|
      __typename: string,
      content: ?string,
      id: string,
      createdAt: any,
      updatedAt: any,
      owner: ?string,
    |} >,
    nextToken: ?string,
  |},
|};

export type OnCreatePatientSubscriptionVariables = {|
  filter?: ?ModelSubscriptionPatientFilterInput,
|};

export type OnCreatePatientSubscription = {|
  onCreatePatient: ? {|
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: any,
    updatedAt: any,
  |},
|};

export type OnUpdatePatientSubscriptionVariables = {|
  filter?: ?ModelSubscriptionPatientFilterInput,
|};

export type OnUpdatePatientSubscription = {|
  onUpdatePatient: ? {|
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: any,
    updatedAt: any,
  |},
|};

export type OnDeletePatientSubscriptionVariables = {|
  filter?: ?ModelSubscriptionPatientFilterInput,
|};

export type OnDeletePatientSubscription = {|
  onDeletePatient: ? {|
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: any,
    updatedAt: any,
  |},
|};

export type OnCreateMedicalAppointmentSubscriptionVariables = {|
  filter?: ?ModelSubscriptionMedicalAppointmentFilterInput,
|};

export type OnCreateMedicalAppointmentSubscription = {|
  onCreateMedicalAppointment: ? {|
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient: ? {|
      __typename: string,
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: any,
      updatedAt: any,
    |},
    provider: ?string,
    date: ?any,
    createdAt: any,
    updatedAt: any,
    medicalAppointmentPatientSsn: ?string,
    medicalAppointmentPatientGivenName: ?string,
    medicalAppointmentPatientFamilyName: ?string,
  |},
|};

export type OnUpdateMedicalAppointmentSubscriptionVariables = {|
  filter?: ?ModelSubscriptionMedicalAppointmentFilterInput,
|};

export type OnUpdateMedicalAppointmentSubscription = {|
  onUpdateMedicalAppointment: ? {|
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient: ? {|
      __typename: string,
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: any,
      updatedAt: any,
    |},
    provider: ?string,
    date: ?any,
    createdAt: any,
    updatedAt: any,
    medicalAppointmentPatientSsn: ?string,
    medicalAppointmentPatientGivenName: ?string,
    medicalAppointmentPatientFamilyName: ?string,
  |},
|};

export type OnDeleteMedicalAppointmentSubscriptionVariables = {|
  filter?: ?ModelSubscriptionMedicalAppointmentFilterInput,
|};

export type OnDeleteMedicalAppointmentSubscription = {|
  onDeleteMedicalAppointment: ? {|
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient: ? {|
      __typename: string,
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: any,
      updatedAt: any,
    |},
    provider: ?string,
    date: ?any,
    createdAt: any,
    updatedAt: any,
    medicalAppointmentPatientSsn: ?string,
    medicalAppointmentPatientGivenName: ?string,
    medicalAppointmentPatientFamilyName: ?string,
  |},
|};

export type OnCreateTodoSubscriptionVariables = {|
  filter?: ?ModelSubscriptionTodoFilterInput,
  owner?: ?string,
|};

export type OnCreateTodoSubscription = {|
  onCreateTodo: ? {|
    __typename: "Todo",
    content: ?string,
    id: string,
    createdAt: any,
    updatedAt: any,
    owner: ?string,
  |},
|};

export type OnUpdateTodoSubscriptionVariables = {|
  filter?: ?ModelSubscriptionTodoFilterInput,
  owner?: ?string,
|};

export type OnUpdateTodoSubscription = {|
  onUpdateTodo: ? {|
    __typename: "Todo",
    content: ?string,
    id: string,
    createdAt: any,
    updatedAt: any,
    owner: ?string,
  |},
|};

export type OnDeleteTodoSubscriptionVariables = {|
  filter?: ?ModelSubscriptionTodoFilterInput,
  owner?: ?string,
|};

export type OnDeleteTodoSubscription = {|
  onDeleteTodo: ? {|
    __typename: "Todo",
    content: ?string,
    id: string,
    createdAt: any,
    updatedAt: any,
    owner: ?string,
  |},
|};