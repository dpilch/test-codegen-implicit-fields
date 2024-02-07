// @flow
// this is an auto generated file. This will be overwritten

export const createPatient = /* GraphQL */ `
  mutation CreatePatient(
    $input: CreatePatientInput!
    $condition: ModelPatientConditionInput
  ) {
    createPatient(input: $input, condition: $condition) {
      ssn
      givenName
      familyName
      createdAt
      updatedAt
      __typename
    }
  }
`;
export const updatePatient = /* GraphQL */ `
  mutation UpdatePatient(
    $input: UpdatePatientInput!
    $condition: ModelPatientConditionInput
  ) {
    updatePatient(input: $input, condition: $condition) {
      ssn
      givenName
      familyName
      createdAt
      updatedAt
      __typename
    }
  }
`;
export const deletePatient = /* GraphQL */ `
  mutation DeletePatient(
    $input: DeletePatientInput!
    $condition: ModelPatientConditionInput
  ) {
    deletePatient(input: $input, condition: $condition) {
      ssn
      givenName
      familyName
      createdAt
      updatedAt
      __typename
    }
  }
`;
export const createMedicalAppointment = /* GraphQL */ `
  mutation CreateMedicalAppointment(
    $input: CreateMedicalAppointmentInput!
    $condition: ModelMedicalAppointmentConditionInput
  ) {
    createMedicalAppointment(input: $input, condition: $condition) {
      appointmentReference
      patient {
        ssn
        givenName
        familyName
        createdAt
        updatedAt
        __typename
      }
      provider
      date
      createdAt
      updatedAt
      medicalAppointmentPatientSsn
      medicalAppointmentPatientGivenName
      medicalAppointmentPatientFamilyName
      __typename
    }
  }
`;
export const updateMedicalAppointment = /* GraphQL */ `
  mutation UpdateMedicalAppointment(
    $input: UpdateMedicalAppointmentInput!
    $condition: ModelMedicalAppointmentConditionInput
  ) {
    updateMedicalAppointment(input: $input, condition: $condition) {
      appointmentReference
      patient {
        ssn
        givenName
        familyName
        createdAt
        updatedAt
        __typename
      }
      provider
      date
      createdAt
      updatedAt
      medicalAppointmentPatientSsn
      medicalAppointmentPatientGivenName
      medicalAppointmentPatientFamilyName
      __typename
    }
  }
`;
export const deleteMedicalAppointment = /* GraphQL */ `
  mutation DeleteMedicalAppointment(
    $input: DeleteMedicalAppointmentInput!
    $condition: ModelMedicalAppointmentConditionInput
  ) {
    deleteMedicalAppointment(input: $input, condition: $condition) {
      appointmentReference
      patient {
        ssn
        givenName
        familyName
        createdAt
        updatedAt
        __typename
      }
      provider
      date
      createdAt
      updatedAt
      medicalAppointmentPatientSsn
      medicalAppointmentPatientGivenName
      medicalAppointmentPatientFamilyName
      __typename
    }
  }
`;
export const createTodo = /* GraphQL */ `
  mutation CreateTodo(
    $input: CreateTodoInput!
    $condition: ModelTodoConditionInput
  ) {
    createTodo(input: $input, condition: $condition) {
      content
      id
      createdAt
      updatedAt
      owner
      __typename
    }
  }
`;
export const updateTodo = /* GraphQL */ `
  mutation UpdateTodo(
    $input: UpdateTodoInput!
    $condition: ModelTodoConditionInput
  ) {
    updateTodo(input: $input, condition: $condition) {
      content
      id
      createdAt
      updatedAt
      owner
      __typename
    }
  }
`;
export const deleteTodo = /* GraphQL */ `
  mutation DeleteTodo(
    $input: DeleteTodoInput!
    $condition: ModelTodoConditionInput
  ) {
    deleteTodo(input: $input, condition: $condition) {
      content
      id
      createdAt
      updatedAt
      owner
      __typename
    }
  }
`;
