/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "../API";
type GeneratedQuery<InputType, OutputType> = string & {
  __generatedQueryInput: InputType;
  __generatedQueryOutput: OutputType;
};

export const getPatient = /* GraphQL */ `query GetPatient($ssn: ID!, $givenName: String!, $familyName: String!) {
  getPatient(ssn: $ssn, givenName: $givenName, familyName: $familyName) {
    ssn
    givenName
    familyName
    createdAt
    updatedAt
    __typename
  }
}
` as GeneratedQuery<
  APITypes.GetPatientQueryVariables,
  APITypes.GetPatientQuery
>;
export const listPatients = /* GraphQL */ `query ListPatients(
  $ssn: ID
  $givenNameFamilyName: ModelPatientPrimaryCompositeKeyConditionInput
  $filter: ModelPatientFilterInput
  $limit: Int
  $nextToken: String
  $sortDirection: ModelSortDirection
) {
  listPatients(
    ssn: $ssn
    givenNameFamilyName: $givenNameFamilyName
    filter: $filter
    limit: $limit
    nextToken: $nextToken
    sortDirection: $sortDirection
  ) {
    items {
      ssn
      givenName
      familyName
      createdAt
      updatedAt
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListPatientsQueryVariables,
  APITypes.ListPatientsQuery
>;
export const getMedicalAppointment = /* GraphQL */ `query GetMedicalAppointment($appointmentReference: ID!) {
  getMedicalAppointment(appointmentReference: $appointmentReference) {
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
` as GeneratedQuery<
  APITypes.GetMedicalAppointmentQueryVariables,
  APITypes.GetMedicalAppointmentQuery
>;
export const listMedicalAppointments = /* GraphQL */ `query ListMedicalAppointments(
  $appointmentReference: ID
  $filter: ModelMedicalAppointmentFilterInput
  $limit: Int
  $nextToken: String
  $sortDirection: ModelSortDirection
) {
  listMedicalAppointments(
    appointmentReference: $appointmentReference
    filter: $filter
    limit: $limit
    nextToken: $nextToken
    sortDirection: $sortDirection
  ) {
    items {
      appointmentReference
      provider
      date
      createdAt
      updatedAt
      medicalAppointmentPatientSsn
      medicalAppointmentPatientGivenName
      medicalAppointmentPatientFamilyName
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListMedicalAppointmentsQueryVariables,
  APITypes.ListMedicalAppointmentsQuery
>;
export const getTodo = /* GraphQL */ `query GetTodo($id: ID!) {
  getTodo(id: $id) {
    content
    id
    createdAt
    updatedAt
    owner
    __typename
  }
}
` as GeneratedQuery<APITypes.GetTodoQueryVariables, APITypes.GetTodoQuery>;
export const listTodos = /* GraphQL */ `query ListTodos(
  $filter: ModelTodoFilterInput
  $limit: Int
  $nextToken: String
) {
  listTodos(filter: $filter, limit: $limit, nextToken: $nextToken) {
    items {
      content
      id
      createdAt
      updatedAt
      owner
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<APITypes.ListTodosQueryVariables, APITypes.ListTodosQuery>;
