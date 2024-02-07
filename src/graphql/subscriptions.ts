/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "../API";
type GeneratedSubscription<InputType, OutputType> = string & {
  __generatedSubscriptionInput: InputType;
  __generatedSubscriptionOutput: OutputType;
};

export const onCreatePatient = /* GraphQL */ `subscription OnCreatePatient($filter: ModelSubscriptionPatientFilterInput) {
  onCreatePatient(filter: $filter) {
    ssn
    givenName
    familyName
    createdAt
    updatedAt
    __typename
  }
}
` as GeneratedSubscription<
  APITypes.OnCreatePatientSubscriptionVariables,
  APITypes.OnCreatePatientSubscription
>;
export const onUpdatePatient = /* GraphQL */ `subscription OnUpdatePatient($filter: ModelSubscriptionPatientFilterInput) {
  onUpdatePatient(filter: $filter) {
    ssn
    givenName
    familyName
    createdAt
    updatedAt
    __typename
  }
}
` as GeneratedSubscription<
  APITypes.OnUpdatePatientSubscriptionVariables,
  APITypes.OnUpdatePatientSubscription
>;
export const onDeletePatient = /* GraphQL */ `subscription OnDeletePatient($filter: ModelSubscriptionPatientFilterInput) {
  onDeletePatient(filter: $filter) {
    ssn
    givenName
    familyName
    createdAt
    updatedAt
    __typename
  }
}
` as GeneratedSubscription<
  APITypes.OnDeletePatientSubscriptionVariables,
  APITypes.OnDeletePatientSubscription
>;
export const onCreateMedicalAppointment = /* GraphQL */ `subscription OnCreateMedicalAppointment(
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
` as GeneratedSubscription<
  APITypes.OnCreateMedicalAppointmentSubscriptionVariables,
  APITypes.OnCreateMedicalAppointmentSubscription
>;
export const onUpdateMedicalAppointment = /* GraphQL */ `subscription OnUpdateMedicalAppointment(
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
` as GeneratedSubscription<
  APITypes.OnUpdateMedicalAppointmentSubscriptionVariables,
  APITypes.OnUpdateMedicalAppointmentSubscription
>;
export const onDeleteMedicalAppointment = /* GraphQL */ `subscription OnDeleteMedicalAppointment(
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
` as GeneratedSubscription<
  APITypes.OnDeleteMedicalAppointmentSubscriptionVariables,
  APITypes.OnDeleteMedicalAppointmentSubscription
>;
export const onCreateTodo = /* GraphQL */ `subscription OnCreateTodo(
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
` as GeneratedSubscription<
  APITypes.OnCreateTodoSubscriptionVariables,
  APITypes.OnCreateTodoSubscription
>;
export const onUpdateTodo = /* GraphQL */ `subscription OnUpdateTodo(
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
` as GeneratedSubscription<
  APITypes.OnUpdateTodoSubscriptionVariables,
  APITypes.OnUpdateTodoSubscription
>;
export const onDeleteTodo = /* GraphQL */ `subscription OnDeleteTodo(
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
` as GeneratedSubscription<
  APITypes.OnDeleteTodoSubscriptionVariables,
  APITypes.OnDeleteTodoSubscription
>;
