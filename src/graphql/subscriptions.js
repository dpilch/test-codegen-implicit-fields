// @flow
// this is an auto generated file. This will be overwritten

export const onCreatePatient = /* GraphQL */ `
  subscription OnCreatePatient($filter: ModelSubscriptionPatientFilterInput) {
    onCreatePatient(filter: $filter) {
      ssn
      givenName
      familyName
      createdAt
      updatedAt
      __typename
    }
  }
`;
export const onUpdatePatient = /* GraphQL */ `
  subscription OnUpdatePatient($filter: ModelSubscriptionPatientFilterInput) {
    onUpdatePatient(filter: $filter) {
      ssn
      givenName
      familyName
      createdAt
      updatedAt
      __typename
    }
  }
`;
export const onDeletePatient = /* GraphQL */ `
  subscription OnDeletePatient($filter: ModelSubscriptionPatientFilterInput) {
    onDeletePatient(filter: $filter) {
      ssn
      givenName
      familyName
      createdAt
      updatedAt
      __typename
    }
  }
`;
export const onCreateMedicalAppointment = /* GraphQL */ `
  subscription OnCreateMedicalAppointment(
    $filter: ModelSubscriptionMedicalAppointmentFilterInput
  ) {
    onCreateMedicalAppointment(filter: $filter) {
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
export const onUpdateMedicalAppointment = /* GraphQL */ `
  subscription OnUpdateMedicalAppointment(
    $filter: ModelSubscriptionMedicalAppointmentFilterInput
  ) {
    onUpdateMedicalAppointment(filter: $filter) {
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
export const onDeleteMedicalAppointment = /* GraphQL */ `
  subscription OnDeleteMedicalAppointment(
    $filter: ModelSubscriptionMedicalAppointmentFilterInput
  ) {
    onDeleteMedicalAppointment(filter: $filter) {
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
export const onCreateTodo = /* GraphQL */ `
  subscription OnCreateTodo(
    $filter: ModelSubscriptionTodoFilterInput
    $owner: String
  ) {
    onCreateTodo(filter: $filter, owner: $owner) {
      content
      id
      createdAt
      updatedAt
      owner
      __typename
    }
  }
`;
export const onUpdateTodo = /* GraphQL */ `
  subscription OnUpdateTodo(
    $filter: ModelSubscriptionTodoFilterInput
    $owner: String
  ) {
    onUpdateTodo(filter: $filter, owner: $owner) {
      content
      id
      createdAt
      updatedAt
      owner
      __typename
    }
  }
`;
export const onDeleteTodo = /* GraphQL */ `
  subscription OnDeleteTodo(
    $filter: ModelSubscriptionTodoFilterInput
    $owner: String
  ) {
    onDeleteTodo(filter: $filter, owner: $owner) {
      content
      id
      createdAt
      updatedAt
      owner
      __typename
    }
  }
`;
