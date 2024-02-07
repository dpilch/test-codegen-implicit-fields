/* tslint:disable */
/* eslint-disable */
//  This file was automatically generated and should not be edited.

export type CreatePatientInput = {
  ssn: string,
  givenName: string,
  familyName: string,
};

export type ModelPatientConditionInput = {
  and?: Array< ModelPatientConditionInput | null > | null,
  or?: Array< ModelPatientConditionInput | null > | null,
  not?: ModelPatientConditionInput | null,
};

export type Patient = {
  __typename: "Patient",
  ssn: string,
  givenName: string,
  familyName: string,
  createdAt: string,
  updatedAt: string,
};

export type UpdatePatientInput = {
  ssn: string,
  givenName: string,
  familyName: string,
};

export type DeletePatientInput = {
  ssn: string,
  givenName: string,
  familyName: string,
};

export type CreateMedicalAppointmentInput = {
  appointmentReference: string,
  provider?: string | null,
  date?: string | null,
  medicalAppointmentPatientSsn?: string | null,
  medicalAppointmentPatientGivenName?: string | null,
  medicalAppointmentPatientFamilyName?: string | null,
};

export type ModelMedicalAppointmentConditionInput = {
  provider?: ModelStringInput | null,
  date?: ModelStringInput | null,
  and?: Array< ModelMedicalAppointmentConditionInput | null > | null,
  or?: Array< ModelMedicalAppointmentConditionInput | null > | null,
  not?: ModelMedicalAppointmentConditionInput | null,
  medicalAppointmentPatientSsn?: ModelIDInput | null,
  medicalAppointmentPatientGivenName?: ModelStringInput | null,
  medicalAppointmentPatientFamilyName?: ModelStringInput | null,
};

export type ModelStringInput = {
  ne?: string | null,
  eq?: string | null,
  le?: string | null,
  lt?: string | null,
  ge?: string | null,
  gt?: string | null,
  contains?: string | null,
  notContains?: string | null,
  between?: Array< string | null > | null,
  beginsWith?: string | null,
  attributeExists?: boolean | null,
  attributeType?: ModelAttributeTypes | null,
  size?: ModelSizeInput | null,
};

export enum ModelAttributeTypes {
  binary = "binary",
  binarySet = "binarySet",
  bool = "bool",
  list = "list",
  map = "map",
  number = "number",
  numberSet = "numberSet",
  string = "string",
  stringSet = "stringSet",
  _null = "_null",
}


export type ModelSizeInput = {
  ne?: number | null,
  eq?: number | null,
  le?: number | null,
  lt?: number | null,
  ge?: number | null,
  gt?: number | null,
  between?: Array< number | null > | null,
};

export type ModelIDInput = {
  ne?: string | null,
  eq?: string | null,
  le?: string | null,
  lt?: string | null,
  ge?: string | null,
  gt?: string | null,
  contains?: string | null,
  notContains?: string | null,
  between?: Array< string | null > | null,
  beginsWith?: string | null,
  attributeExists?: boolean | null,
  attributeType?: ModelAttributeTypes | null,
  size?: ModelSizeInput | null,
};

export type MedicalAppointment = {
  __typename: "MedicalAppointment",
  appointmentReference: string,
  patient?: Patient | null,
  provider?: string | null,
  date?: string | null,
  createdAt: string,
  updatedAt: string,
  medicalAppointmentPatientSsn?: string | null,
  medicalAppointmentPatientGivenName?: string | null,
  medicalAppointmentPatientFamilyName?: string | null,
};

export type UpdateMedicalAppointmentInput = {
  appointmentReference: string,
  provider?: string | null,
  date?: string | null,
  medicalAppointmentPatientSsn?: string | null,
  medicalAppointmentPatientGivenName?: string | null,
  medicalAppointmentPatientFamilyName?: string | null,
};

export type DeleteMedicalAppointmentInput = {
  appointmentReference: string,
};

export type CreateTodoInput = {
  content?: string | null,
  id?: string | null,
};

export type ModelTodoConditionInput = {
  content?: ModelStringInput | null,
  and?: Array< ModelTodoConditionInput | null > | null,
  or?: Array< ModelTodoConditionInput | null > | null,
  not?: ModelTodoConditionInput | null,
};

export type Todo = {
  __typename: "Todo",
  content?: string | null,
  id: string,
  createdAt: string,
  updatedAt: string,
  owner?: string | null,
};

export type UpdateTodoInput = {
  content?: string | null,
  id: string,
};

export type DeleteTodoInput = {
  id: string,
};

export type ModelPatientPrimaryCompositeKeyConditionInput = {
  eq?: ModelPatientPrimaryCompositeKeyInput | null,
  le?: ModelPatientPrimaryCompositeKeyInput | null,
  lt?: ModelPatientPrimaryCompositeKeyInput | null,
  ge?: ModelPatientPrimaryCompositeKeyInput | null,
  gt?: ModelPatientPrimaryCompositeKeyInput | null,
  between?: Array< ModelPatientPrimaryCompositeKeyInput | null > | null,
  beginsWith?: ModelPatientPrimaryCompositeKeyInput | null,
};

export type ModelPatientPrimaryCompositeKeyInput = {
  givenName?: string | null,
  familyName?: string | null,
};

export type ModelPatientFilterInput = {
  ssn?: ModelIDInput | null,
  givenName?: ModelStringInput | null,
  familyName?: ModelStringInput | null,
  and?: Array< ModelPatientFilterInput | null > | null,
  or?: Array< ModelPatientFilterInput | null > | null,
  not?: ModelPatientFilterInput | null,
};

export enum ModelSortDirection {
  ASC = "ASC",
  DESC = "DESC",
}


export type ModelPatientConnection = {
  __typename: "ModelPatientConnection",
  items:  Array<Patient | null >,
  nextToken?: string | null,
};

export type ModelMedicalAppointmentFilterInput = {
  appointmentReference?: ModelIDInput | null,
  provider?: ModelStringInput | null,
  date?: ModelStringInput | null,
  and?: Array< ModelMedicalAppointmentFilterInput | null > | null,
  or?: Array< ModelMedicalAppointmentFilterInput | null > | null,
  not?: ModelMedicalAppointmentFilterInput | null,
  medicalAppointmentPatientSsn?: ModelIDInput | null,
  medicalAppointmentPatientGivenName?: ModelStringInput | null,
  medicalAppointmentPatientFamilyName?: ModelStringInput | null,
};

export type ModelMedicalAppointmentConnection = {
  __typename: "ModelMedicalAppointmentConnection",
  items:  Array<MedicalAppointment | null >,
  nextToken?: string | null,
};

export type ModelTodoFilterInput = {
  content?: ModelStringInput | null,
  and?: Array< ModelTodoFilterInput | null > | null,
  or?: Array< ModelTodoFilterInput | null > | null,
  not?: ModelTodoFilterInput | null,
};

export type ModelTodoConnection = {
  __typename: "ModelTodoConnection",
  items:  Array<Todo | null >,
  nextToken?: string | null,
};

export type ModelSubscriptionPatientFilterInput = {
  ssn?: ModelSubscriptionIDInput | null,
  givenName?: ModelSubscriptionStringInput | null,
  familyName?: ModelSubscriptionStringInput | null,
  and?: Array< ModelSubscriptionPatientFilterInput | null > | null,
  or?: Array< ModelSubscriptionPatientFilterInput | null > | null,
};

export type ModelSubscriptionIDInput = {
  ne?: string | null,
  eq?: string | null,
  le?: string | null,
  lt?: string | null,
  ge?: string | null,
  gt?: string | null,
  contains?: string | null,
  notContains?: string | null,
  between?: Array< string | null > | null,
  beginsWith?: string | null,
  in?: Array< string | null > | null,
  notIn?: Array< string | null > | null,
};

export type ModelSubscriptionStringInput = {
  ne?: string | null,
  eq?: string | null,
  le?: string | null,
  lt?: string | null,
  ge?: string | null,
  gt?: string | null,
  contains?: string | null,
  notContains?: string | null,
  between?: Array< string | null > | null,
  beginsWith?: string | null,
  in?: Array< string | null > | null,
  notIn?: Array< string | null > | null,
};

export type ModelSubscriptionMedicalAppointmentFilterInput = {
  appointmentReference?: ModelSubscriptionIDInput | null,
  provider?: ModelSubscriptionStringInput | null,
  date?: ModelSubscriptionStringInput | null,
  and?: Array< ModelSubscriptionMedicalAppointmentFilterInput | null > | null,
  or?: Array< ModelSubscriptionMedicalAppointmentFilterInput | null > | null,
};

export type ModelSubscriptionTodoFilterInput = {
  content?: ModelSubscriptionStringInput | null,
  and?: Array< ModelSubscriptionTodoFilterInput | null > | null,
  or?: Array< ModelSubscriptionTodoFilterInput | null > | null,
};

export type CreatePatientMutationVariables = {
  input: CreatePatientInput,
  condition?: ModelPatientConditionInput | null,
};

export type CreatePatientMutation = {
  createPatient?:  {
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: string,
    updatedAt: string,
  } | null,
};

export type UpdatePatientMutationVariables = {
  input: UpdatePatientInput,
  condition?: ModelPatientConditionInput | null,
};

export type UpdatePatientMutation = {
  updatePatient?:  {
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: string,
    updatedAt: string,
  } | null,
};

export type DeletePatientMutationVariables = {
  input: DeletePatientInput,
  condition?: ModelPatientConditionInput | null,
};

export type DeletePatientMutation = {
  deletePatient?:  {
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: string,
    updatedAt: string,
  } | null,
};

export type CreateMedicalAppointmentMutationVariables = {
  input: CreateMedicalAppointmentInput,
  condition?: ModelMedicalAppointmentConditionInput | null,
};

export type CreateMedicalAppointmentMutation = {
  createMedicalAppointment?:  {
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient?:  {
      __typename: "Patient",
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: string,
      updatedAt: string,
    } | null,
    provider?: string | null,
    date?: string | null,
    createdAt: string,
    updatedAt: string,
    medicalAppointmentPatientSsn?: string | null,
    medicalAppointmentPatientGivenName?: string | null,
    medicalAppointmentPatientFamilyName?: string | null,
  } | null,
};

export type UpdateMedicalAppointmentMutationVariables = {
  input: UpdateMedicalAppointmentInput,
  condition?: ModelMedicalAppointmentConditionInput | null,
};

export type UpdateMedicalAppointmentMutation = {
  updateMedicalAppointment?:  {
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient?:  {
      __typename: "Patient",
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: string,
      updatedAt: string,
    } | null,
    provider?: string | null,
    date?: string | null,
    createdAt: string,
    updatedAt: string,
    medicalAppointmentPatientSsn?: string | null,
    medicalAppointmentPatientGivenName?: string | null,
    medicalAppointmentPatientFamilyName?: string | null,
  } | null,
};

export type DeleteMedicalAppointmentMutationVariables = {
  input: DeleteMedicalAppointmentInput,
  condition?: ModelMedicalAppointmentConditionInput | null,
};

export type DeleteMedicalAppointmentMutation = {
  deleteMedicalAppointment?:  {
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient?:  {
      __typename: "Patient",
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: string,
      updatedAt: string,
    } | null,
    provider?: string | null,
    date?: string | null,
    createdAt: string,
    updatedAt: string,
    medicalAppointmentPatientSsn?: string | null,
    medicalAppointmentPatientGivenName?: string | null,
    medicalAppointmentPatientFamilyName?: string | null,
  } | null,
};

export type CreateTodoMutationVariables = {
  input: CreateTodoInput,
  condition?: ModelTodoConditionInput | null,
};

export type CreateTodoMutation = {
  createTodo?:  {
    __typename: "Todo",
    content?: string | null,
    id: string,
    createdAt: string,
    updatedAt: string,
    owner?: string | null,
  } | null,
};

export type UpdateTodoMutationVariables = {
  input: UpdateTodoInput,
  condition?: ModelTodoConditionInput | null,
};

export type UpdateTodoMutation = {
  updateTodo?:  {
    __typename: "Todo",
    content?: string | null,
    id: string,
    createdAt: string,
    updatedAt: string,
    owner?: string | null,
  } | null,
};

export type DeleteTodoMutationVariables = {
  input: DeleteTodoInput,
  condition?: ModelTodoConditionInput | null,
};

export type DeleteTodoMutation = {
  deleteTodo?:  {
    __typename: "Todo",
    content?: string | null,
    id: string,
    createdAt: string,
    updatedAt: string,
    owner?: string | null,
  } | null,
};

export type GetPatientQueryVariables = {
  ssn: string,
  givenName: string,
  familyName: string,
};

export type GetPatientQuery = {
  getPatient?:  {
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: string,
    updatedAt: string,
  } | null,
};

export type ListPatientsQueryVariables = {
  ssn?: string | null,
  givenNameFamilyName?: ModelPatientPrimaryCompositeKeyConditionInput | null,
  filter?: ModelPatientFilterInput | null,
  limit?: number | null,
  nextToken?: string | null,
  sortDirection?: ModelSortDirection | null,
};

export type ListPatientsQuery = {
  listPatients?:  {
    __typename: "ModelPatientConnection",
    items:  Array< {
      __typename: "Patient",
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: string,
      updatedAt: string,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type GetMedicalAppointmentQueryVariables = {
  appointmentReference: string,
};

export type GetMedicalAppointmentQuery = {
  getMedicalAppointment?:  {
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient?:  {
      __typename: "Patient",
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: string,
      updatedAt: string,
    } | null,
    provider?: string | null,
    date?: string | null,
    createdAt: string,
    updatedAt: string,
    medicalAppointmentPatientSsn?: string | null,
    medicalAppointmentPatientGivenName?: string | null,
    medicalAppointmentPatientFamilyName?: string | null,
  } | null,
};

export type ListMedicalAppointmentsQueryVariables = {
  appointmentReference?: string | null,
  filter?: ModelMedicalAppointmentFilterInput | null,
  limit?: number | null,
  nextToken?: string | null,
  sortDirection?: ModelSortDirection | null,
};

export type ListMedicalAppointmentsQuery = {
  listMedicalAppointments?:  {
    __typename: "ModelMedicalAppointmentConnection",
    items:  Array< {
      __typename: "MedicalAppointment",
      appointmentReference: string,
      provider?: string | null,
      date?: string | null,
      createdAt: string,
      updatedAt: string,
      medicalAppointmentPatientSsn?: string | null,
      medicalAppointmentPatientGivenName?: string | null,
      medicalAppointmentPatientFamilyName?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type GetTodoQueryVariables = {
  id: string,
};

export type GetTodoQuery = {
  getTodo?:  {
    __typename: "Todo",
    content?: string | null,
    id: string,
    createdAt: string,
    updatedAt: string,
    owner?: string | null,
  } | null,
};

export type ListTodosQueryVariables = {
  filter?: ModelTodoFilterInput | null,
  limit?: number | null,
  nextToken?: string | null,
};

export type ListTodosQuery = {
  listTodos?:  {
    __typename: "ModelTodoConnection",
    items:  Array< {
      __typename: "Todo",
      content?: string | null,
      id: string,
      createdAt: string,
      updatedAt: string,
      owner?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type OnCreatePatientSubscriptionVariables = {
  filter?: ModelSubscriptionPatientFilterInput | null,
};

export type OnCreatePatientSubscription = {
  onCreatePatient?:  {
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: string,
    updatedAt: string,
  } | null,
};

export type OnUpdatePatientSubscriptionVariables = {
  filter?: ModelSubscriptionPatientFilterInput | null,
};

export type OnUpdatePatientSubscription = {
  onUpdatePatient?:  {
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: string,
    updatedAt: string,
  } | null,
};

export type OnDeletePatientSubscriptionVariables = {
  filter?: ModelSubscriptionPatientFilterInput | null,
};

export type OnDeletePatientSubscription = {
  onDeletePatient?:  {
    __typename: "Patient",
    ssn: string,
    givenName: string,
    familyName: string,
    createdAt: string,
    updatedAt: string,
  } | null,
};

export type OnCreateMedicalAppointmentSubscriptionVariables = {
  filter?: ModelSubscriptionMedicalAppointmentFilterInput | null,
};

export type OnCreateMedicalAppointmentSubscription = {
  onCreateMedicalAppointment?:  {
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient?:  {
      __typename: "Patient",
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: string,
      updatedAt: string,
    } | null,
    provider?: string | null,
    date?: string | null,
    createdAt: string,
    updatedAt: string,
    medicalAppointmentPatientSsn?: string | null,
    medicalAppointmentPatientGivenName?: string | null,
    medicalAppointmentPatientFamilyName?: string | null,
  } | null,
};

export type OnUpdateMedicalAppointmentSubscriptionVariables = {
  filter?: ModelSubscriptionMedicalAppointmentFilterInput | null,
};

export type OnUpdateMedicalAppointmentSubscription = {
  onUpdateMedicalAppointment?:  {
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient?:  {
      __typename: "Patient",
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: string,
      updatedAt: string,
    } | null,
    provider?: string | null,
    date?: string | null,
    createdAt: string,
    updatedAt: string,
    medicalAppointmentPatientSsn?: string | null,
    medicalAppointmentPatientGivenName?: string | null,
    medicalAppointmentPatientFamilyName?: string | null,
  } | null,
};

export type OnDeleteMedicalAppointmentSubscriptionVariables = {
  filter?: ModelSubscriptionMedicalAppointmentFilterInput | null,
};

export type OnDeleteMedicalAppointmentSubscription = {
  onDeleteMedicalAppointment?:  {
    __typename: "MedicalAppointment",
    appointmentReference: string,
    patient?:  {
      __typename: "Patient",
      ssn: string,
      givenName: string,
      familyName: string,
      createdAt: string,
      updatedAt: string,
    } | null,
    provider?: string | null,
    date?: string | null,
    createdAt: string,
    updatedAt: string,
    medicalAppointmentPatientSsn?: string | null,
    medicalAppointmentPatientGivenName?: string | null,
    medicalAppointmentPatientFamilyName?: string | null,
  } | null,
};

export type OnCreateTodoSubscriptionVariables = {
  filter?: ModelSubscriptionTodoFilterInput | null,
  owner?: string | null,
};

export type OnCreateTodoSubscription = {
  onCreateTodo?:  {
    __typename: "Todo",
    content?: string | null,
    id: string,
    createdAt: string,
    updatedAt: string,
    owner?: string | null,
  } | null,
};

export type OnUpdateTodoSubscriptionVariables = {
  filter?: ModelSubscriptionTodoFilterInput | null,
  owner?: string | null,
};

export type OnUpdateTodoSubscription = {
  onUpdateTodo?:  {
    __typename: "Todo",
    content?: string | null,
    id: string,
    createdAt: string,
    updatedAt: string,
    owner?: string | null,
  } | null,
};

export type OnDeleteTodoSubscriptionVariables = {
  filter?: ModelSubscriptionTodoFilterInput | null,
  owner?: string | null,
};

export type OnDeleteTodoSubscription = {
  onDeleteTodo?:  {
    __typename: "Todo",
    content?: string | null,
    id: string,
    createdAt: string,
    updatedAt: string,
    owner?: string | null,
  } | null,
};
