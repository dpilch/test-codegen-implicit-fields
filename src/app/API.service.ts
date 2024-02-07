/* tslint:disable */
/* eslint-disable */
//  This file was automatically generated and should not be edited.
import { Injectable } from "@angular/core";
import API, { graphqlOperation, GraphQLResult } from "@aws-amplify/api-graphql";
import { Observable } from "zen-observable-ts";

export interface SubscriptionResponse<T> {
  value: GraphQLResult<T>;
}

export type __SubscriptionContainer = {
  onCreatePatient: OnCreatePatientSubscription;
  onUpdatePatient: OnUpdatePatientSubscription;
  onDeletePatient: OnDeletePatientSubscription;
  onCreateMedicalAppointment: OnCreateMedicalAppointmentSubscription;
  onUpdateMedicalAppointment: OnUpdateMedicalAppointmentSubscription;
  onDeleteMedicalAppointment: OnDeleteMedicalAppointmentSubscription;
  onCreateTodo: OnCreateTodoSubscription;
  onUpdateTodo: OnUpdateTodoSubscription;
  onDeleteTodo: OnDeleteTodoSubscription;
};

export type CreatePatientInput = {
  ssn: string;
  givenName: string;
  familyName: string;
};

export type ModelPatientConditionInput = {
  and?: Array<ModelPatientConditionInput | null> | null;
  or?: Array<ModelPatientConditionInput | null> | null;
  not?: ModelPatientConditionInput | null;
};

export type Patient = {
  __typename: "Patient";
  ssn: string;
  givenName: string;
  familyName: string;
  createdAt: string;
  updatedAt: string;
};

export type UpdatePatientInput = {
  ssn: string;
  givenName: string;
  familyName: string;
};

export type DeletePatientInput = {
  ssn: string;
  givenName: string;
  familyName: string;
};

export type CreateMedicalAppointmentInput = {
  appointmentReference: string;
  provider?: string | null;
  date?: string | null;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type ModelMedicalAppointmentConditionInput = {
  provider?: ModelStringInput | null;
  date?: ModelStringInput | null;
  and?: Array<ModelMedicalAppointmentConditionInput | null> | null;
  or?: Array<ModelMedicalAppointmentConditionInput | null> | null;
  not?: ModelMedicalAppointmentConditionInput | null;
  medicalAppointmentPatientSsn?: ModelIDInput | null;
  medicalAppointmentPatientGivenName?: ModelStringInput | null;
  medicalAppointmentPatientFamilyName?: ModelStringInput | null;
};

export type ModelStringInput = {
  ne?: string | null;
  eq?: string | null;
  le?: string | null;
  lt?: string | null;
  ge?: string | null;
  gt?: string | null;
  contains?: string | null;
  notContains?: string | null;
  between?: Array<string | null> | null;
  beginsWith?: string | null;
  attributeExists?: boolean | null;
  attributeType?: ModelAttributeTypes | null;
  size?: ModelSizeInput | null;
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
  _null = "_null"
}

export type ModelSizeInput = {
  ne?: number | null;
  eq?: number | null;
  le?: number | null;
  lt?: number | null;
  ge?: number | null;
  gt?: number | null;
  between?: Array<number | null> | null;
};

export type ModelIDInput = {
  ne?: string | null;
  eq?: string | null;
  le?: string | null;
  lt?: string | null;
  ge?: string | null;
  gt?: string | null;
  contains?: string | null;
  notContains?: string | null;
  between?: Array<string | null> | null;
  beginsWith?: string | null;
  attributeExists?: boolean | null;
  attributeType?: ModelAttributeTypes | null;
  size?: ModelSizeInput | null;
};

export type MedicalAppointment = {
  __typename: "MedicalAppointment";
  appointmentReference: string;
  patient?: Patient | null;
  provider?: string | null;
  date?: string | null;
  createdAt: string;
  updatedAt: string;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type UpdateMedicalAppointmentInput = {
  appointmentReference: string;
  provider?: string | null;
  date?: string | null;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type DeleteMedicalAppointmentInput = {
  appointmentReference: string;
};

export type CreateTodoInput = {
  content?: string | null;
  id?: string | null;
};

export type ModelTodoConditionInput = {
  content?: ModelStringInput | null;
  and?: Array<ModelTodoConditionInput | null> | null;
  or?: Array<ModelTodoConditionInput | null> | null;
  not?: ModelTodoConditionInput | null;
};

export type Todo = {
  __typename: "Todo";
  content?: string | null;
  id: string;
  createdAt: string;
  updatedAt: string;
  owner?: string | null;
};

export type UpdateTodoInput = {
  content?: string | null;
  id: string;
};

export type DeleteTodoInput = {
  id: string;
};

export type ModelPatientPrimaryCompositeKeyConditionInput = {
  eq?: ModelPatientPrimaryCompositeKeyInput | null;
  le?: ModelPatientPrimaryCompositeKeyInput | null;
  lt?: ModelPatientPrimaryCompositeKeyInput | null;
  ge?: ModelPatientPrimaryCompositeKeyInput | null;
  gt?: ModelPatientPrimaryCompositeKeyInput | null;
  between?: Array<ModelPatientPrimaryCompositeKeyInput | null> | null;
  beginsWith?: ModelPatientPrimaryCompositeKeyInput | null;
};

export type ModelPatientPrimaryCompositeKeyInput = {
  givenName?: string | null;
  familyName?: string | null;
};

export type ModelPatientFilterInput = {
  ssn?: ModelIDInput | null;
  givenName?: ModelStringInput | null;
  familyName?: ModelStringInput | null;
  and?: Array<ModelPatientFilterInput | null> | null;
  or?: Array<ModelPatientFilterInput | null> | null;
  not?: ModelPatientFilterInput | null;
};

export enum ModelSortDirection {
  ASC = "ASC",
  DESC = "DESC"
}

export type ModelPatientConnection = {
  __typename: "ModelPatientConnection";
  items: Array<Patient | null>;
  nextToken?: string | null;
};

export type ModelMedicalAppointmentFilterInput = {
  appointmentReference?: ModelIDInput | null;
  provider?: ModelStringInput | null;
  date?: ModelStringInput | null;
  and?: Array<ModelMedicalAppointmentFilterInput | null> | null;
  or?: Array<ModelMedicalAppointmentFilterInput | null> | null;
  not?: ModelMedicalAppointmentFilterInput | null;
  medicalAppointmentPatientSsn?: ModelIDInput | null;
  medicalAppointmentPatientGivenName?: ModelStringInput | null;
  medicalAppointmentPatientFamilyName?: ModelStringInput | null;
};

export type ModelMedicalAppointmentConnection = {
  __typename: "ModelMedicalAppointmentConnection";
  items: Array<MedicalAppointment | null>;
  nextToken?: string | null;
};

export type ModelTodoFilterInput = {
  content?: ModelStringInput | null;
  and?: Array<ModelTodoFilterInput | null> | null;
  or?: Array<ModelTodoFilterInput | null> | null;
  not?: ModelTodoFilterInput | null;
};

export type ModelTodoConnection = {
  __typename: "ModelTodoConnection";
  items: Array<Todo | null>;
  nextToken?: string | null;
};

export type ModelSubscriptionPatientFilterInput = {
  ssn?: ModelSubscriptionIDInput | null;
  givenName?: ModelSubscriptionStringInput | null;
  familyName?: ModelSubscriptionStringInput | null;
  and?: Array<ModelSubscriptionPatientFilterInput | null> | null;
  or?: Array<ModelSubscriptionPatientFilterInput | null> | null;
};

export type ModelSubscriptionIDInput = {
  ne?: string | null;
  eq?: string | null;
  le?: string | null;
  lt?: string | null;
  ge?: string | null;
  gt?: string | null;
  contains?: string | null;
  notContains?: string | null;
  between?: Array<string | null> | null;
  beginsWith?: string | null;
  in?: Array<string | null> | null;
  notIn?: Array<string | null> | null;
};

export type ModelSubscriptionStringInput = {
  ne?: string | null;
  eq?: string | null;
  le?: string | null;
  lt?: string | null;
  ge?: string | null;
  gt?: string | null;
  contains?: string | null;
  notContains?: string | null;
  between?: Array<string | null> | null;
  beginsWith?: string | null;
  in?: Array<string | null> | null;
  notIn?: Array<string | null> | null;
};

export type ModelSubscriptionMedicalAppointmentFilterInput = {
  appointmentReference?: ModelSubscriptionIDInput | null;
  provider?: ModelSubscriptionStringInput | null;
  date?: ModelSubscriptionStringInput | null;
  and?: Array<ModelSubscriptionMedicalAppointmentFilterInput | null> | null;
  or?: Array<ModelSubscriptionMedicalAppointmentFilterInput | null> | null;
};

export type ModelSubscriptionTodoFilterInput = {
  content?: ModelSubscriptionStringInput | null;
  and?: Array<ModelSubscriptionTodoFilterInput | null> | null;
  or?: Array<ModelSubscriptionTodoFilterInput | null> | null;
};

export type CreatePatientMutation = {
  __typename: "Patient";
  ssn: string;
  givenName: string;
  familyName: string;
  createdAt: string;
  updatedAt: string;
};

export type UpdatePatientMutation = {
  __typename: "Patient";
  ssn: string;
  givenName: string;
  familyName: string;
  createdAt: string;
  updatedAt: string;
};

export type DeletePatientMutation = {
  __typename: "Patient";
  ssn: string;
  givenName: string;
  familyName: string;
  createdAt: string;
  updatedAt: string;
};

export type CreateMedicalAppointmentMutation = {
  __typename: "MedicalAppointment";
  appointmentReference: string;
  patient?: {
    __typename: "Patient";
    ssn: string;
    givenName: string;
    familyName: string;
    createdAt: string;
    updatedAt: string;
  } | null;
  provider?: string | null;
  date?: string | null;
  createdAt: string;
  updatedAt: string;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type UpdateMedicalAppointmentMutation = {
  __typename: "MedicalAppointment";
  appointmentReference: string;
  patient?: {
    __typename: "Patient";
    ssn: string;
    givenName: string;
    familyName: string;
    createdAt: string;
    updatedAt: string;
  } | null;
  provider?: string | null;
  date?: string | null;
  createdAt: string;
  updatedAt: string;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type DeleteMedicalAppointmentMutation = {
  __typename: "MedicalAppointment";
  appointmentReference: string;
  patient?: {
    __typename: "Patient";
    ssn: string;
    givenName: string;
    familyName: string;
    createdAt: string;
    updatedAt: string;
  } | null;
  provider?: string | null;
  date?: string | null;
  createdAt: string;
  updatedAt: string;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type CreateTodoMutation = {
  __typename: "Todo";
  content?: string | null;
  id: string;
  createdAt: string;
  updatedAt: string;
  owner?: string | null;
};

export type UpdateTodoMutation = {
  __typename: "Todo";
  content?: string | null;
  id: string;
  createdAt: string;
  updatedAt: string;
  owner?: string | null;
};

export type DeleteTodoMutation = {
  __typename: "Todo";
  content?: string | null;
  id: string;
  createdAt: string;
  updatedAt: string;
  owner?: string | null;
};

export type GetPatientQuery = {
  __typename: "Patient";
  ssn: string;
  givenName: string;
  familyName: string;
  createdAt: string;
  updatedAt: string;
};

export type ListPatientsQuery = {
  __typename: "ModelPatientConnection";
  items: Array<{
    __typename: "Patient";
    ssn: string;
    givenName: string;
    familyName: string;
    createdAt: string;
    updatedAt: string;
  } | null>;
  nextToken?: string | null;
};

export type GetMedicalAppointmentQuery = {
  __typename: "MedicalAppointment";
  appointmentReference: string;
  patient?: {
    __typename: "Patient";
    ssn: string;
    givenName: string;
    familyName: string;
    createdAt: string;
    updatedAt: string;
  } | null;
  provider?: string | null;
  date?: string | null;
  createdAt: string;
  updatedAt: string;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type ListMedicalAppointmentsQuery = {
  __typename: "ModelMedicalAppointmentConnection";
  items: Array<{
    __typename: "MedicalAppointment";
    appointmentReference: string;
    provider?: string | null;
    date?: string | null;
    createdAt: string;
    updatedAt: string;
    medicalAppointmentPatientSsn?: string | null;
    medicalAppointmentPatientGivenName?: string | null;
    medicalAppointmentPatientFamilyName?: string | null;
  } | null>;
  nextToken?: string | null;
};

export type GetTodoQuery = {
  __typename: "Todo";
  content?: string | null;
  id: string;
  createdAt: string;
  updatedAt: string;
  owner?: string | null;
};

export type ListTodosQuery = {
  __typename: "ModelTodoConnection";
  items: Array<{
    __typename: "Todo";
    content?: string | null;
    id: string;
    createdAt: string;
    updatedAt: string;
    owner?: string | null;
  } | null>;
  nextToken?: string | null;
};

export type OnCreatePatientSubscription = {
  __typename: "Patient";
  ssn: string;
  givenName: string;
  familyName: string;
  createdAt: string;
  updatedAt: string;
};

export type OnUpdatePatientSubscription = {
  __typename: "Patient";
  ssn: string;
  givenName: string;
  familyName: string;
  createdAt: string;
  updatedAt: string;
};

export type OnDeletePatientSubscription = {
  __typename: "Patient";
  ssn: string;
  givenName: string;
  familyName: string;
  createdAt: string;
  updatedAt: string;
};

export type OnCreateMedicalAppointmentSubscription = {
  __typename: "MedicalAppointment";
  appointmentReference: string;
  patient?: {
    __typename: "Patient";
    ssn: string;
    givenName: string;
    familyName: string;
    createdAt: string;
    updatedAt: string;
  } | null;
  provider?: string | null;
  date?: string | null;
  createdAt: string;
  updatedAt: string;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type OnUpdateMedicalAppointmentSubscription = {
  __typename: "MedicalAppointment";
  appointmentReference: string;
  patient?: {
    __typename: "Patient";
    ssn: string;
    givenName: string;
    familyName: string;
    createdAt: string;
    updatedAt: string;
  } | null;
  provider?: string | null;
  date?: string | null;
  createdAt: string;
  updatedAt: string;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type OnDeleteMedicalAppointmentSubscription = {
  __typename: "MedicalAppointment";
  appointmentReference: string;
  patient?: {
    __typename: "Patient";
    ssn: string;
    givenName: string;
    familyName: string;
    createdAt: string;
    updatedAt: string;
  } | null;
  provider?: string | null;
  date?: string | null;
  createdAt: string;
  updatedAt: string;
  medicalAppointmentPatientSsn?: string | null;
  medicalAppointmentPatientGivenName?: string | null;
  medicalAppointmentPatientFamilyName?: string | null;
};

export type OnCreateTodoSubscription = {
  __typename: "Todo";
  content?: string | null;
  id: string;
  createdAt: string;
  updatedAt: string;
  owner?: string | null;
};

export type OnUpdateTodoSubscription = {
  __typename: "Todo";
  content?: string | null;
  id: string;
  createdAt: string;
  updatedAt: string;
  owner?: string | null;
};

export type OnDeleteTodoSubscription = {
  __typename: "Todo";
  content?: string | null;
  id: string;
  createdAt: string;
  updatedAt: string;
  owner?: string | null;
};

@Injectable({
  providedIn: "root"
})
export class APIService {
  async CreatePatient(
    input: CreatePatientInput,
    condition?: ModelPatientConditionInput
  ): Promise<CreatePatientMutation> {
    const statement = `mutation CreatePatient($input: CreatePatientInput!, $condition: ModelPatientConditionInput) {
        createPatient(input: $input, condition: $condition) {
          __typename
          ssn
          givenName
          familyName
          createdAt
          updatedAt
        }
      }`;
    const gqlAPIServiceArguments: any = {
      input
    };
    if (condition) {
      gqlAPIServiceArguments.condition = condition;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <CreatePatientMutation>response.data.createPatient;
  }
  async UpdatePatient(
    input: UpdatePatientInput,
    condition?: ModelPatientConditionInput
  ): Promise<UpdatePatientMutation> {
    const statement = `mutation UpdatePatient($input: UpdatePatientInput!, $condition: ModelPatientConditionInput) {
        updatePatient(input: $input, condition: $condition) {
          __typename
          ssn
          givenName
          familyName
          createdAt
          updatedAt
        }
      }`;
    const gqlAPIServiceArguments: any = {
      input
    };
    if (condition) {
      gqlAPIServiceArguments.condition = condition;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <UpdatePatientMutation>response.data.updatePatient;
  }
  async DeletePatient(
    input: DeletePatientInput,
    condition?: ModelPatientConditionInput
  ): Promise<DeletePatientMutation> {
    const statement = `mutation DeletePatient($input: DeletePatientInput!, $condition: ModelPatientConditionInput) {
        deletePatient(input: $input, condition: $condition) {
          __typename
          ssn
          givenName
          familyName
          createdAt
          updatedAt
        }
      }`;
    const gqlAPIServiceArguments: any = {
      input
    };
    if (condition) {
      gqlAPIServiceArguments.condition = condition;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <DeletePatientMutation>response.data.deletePatient;
  }
  async CreateMedicalAppointment(
    input: CreateMedicalAppointmentInput,
    condition?: ModelMedicalAppointmentConditionInput
  ): Promise<CreateMedicalAppointmentMutation> {
    const statement = `mutation CreateMedicalAppointment($input: CreateMedicalAppointmentInput!, $condition: ModelMedicalAppointmentConditionInput) {
        createMedicalAppointment(input: $input, condition: $condition) {
          __typename
          appointmentReference
          patient {
            __typename
            ssn
            givenName
            familyName
            createdAt
            updatedAt
          }
          provider
          date
          createdAt
          updatedAt
          medicalAppointmentPatientSsn
          medicalAppointmentPatientGivenName
          medicalAppointmentPatientFamilyName
        }
      }`;
    const gqlAPIServiceArguments: any = {
      input
    };
    if (condition) {
      gqlAPIServiceArguments.condition = condition;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <CreateMedicalAppointmentMutation>(
      response.data.createMedicalAppointment
    );
  }
  async UpdateMedicalAppointment(
    input: UpdateMedicalAppointmentInput,
    condition?: ModelMedicalAppointmentConditionInput
  ): Promise<UpdateMedicalAppointmentMutation> {
    const statement = `mutation UpdateMedicalAppointment($input: UpdateMedicalAppointmentInput!, $condition: ModelMedicalAppointmentConditionInput) {
        updateMedicalAppointment(input: $input, condition: $condition) {
          __typename
          appointmentReference
          patient {
            __typename
            ssn
            givenName
            familyName
            createdAt
            updatedAt
          }
          provider
          date
          createdAt
          updatedAt
          medicalAppointmentPatientSsn
          medicalAppointmentPatientGivenName
          medicalAppointmentPatientFamilyName
        }
      }`;
    const gqlAPIServiceArguments: any = {
      input
    };
    if (condition) {
      gqlAPIServiceArguments.condition = condition;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <UpdateMedicalAppointmentMutation>(
      response.data.updateMedicalAppointment
    );
  }
  async DeleteMedicalAppointment(
    input: DeleteMedicalAppointmentInput,
    condition?: ModelMedicalAppointmentConditionInput
  ): Promise<DeleteMedicalAppointmentMutation> {
    const statement = `mutation DeleteMedicalAppointment($input: DeleteMedicalAppointmentInput!, $condition: ModelMedicalAppointmentConditionInput) {
        deleteMedicalAppointment(input: $input, condition: $condition) {
          __typename
          appointmentReference
          patient {
            __typename
            ssn
            givenName
            familyName
            createdAt
            updatedAt
          }
          provider
          date
          createdAt
          updatedAt
          medicalAppointmentPatientSsn
          medicalAppointmentPatientGivenName
          medicalAppointmentPatientFamilyName
        }
      }`;
    const gqlAPIServiceArguments: any = {
      input
    };
    if (condition) {
      gqlAPIServiceArguments.condition = condition;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <DeleteMedicalAppointmentMutation>(
      response.data.deleteMedicalAppointment
    );
  }
  async CreateTodo(
    input: CreateTodoInput,
    condition?: ModelTodoConditionInput
  ): Promise<CreateTodoMutation> {
    const statement = `mutation CreateTodo($input: CreateTodoInput!, $condition: ModelTodoConditionInput) {
        createTodo(input: $input, condition: $condition) {
          __typename
          content
          id
          createdAt
          updatedAt
          owner
        }
      }`;
    const gqlAPIServiceArguments: any = {
      input
    };
    if (condition) {
      gqlAPIServiceArguments.condition = condition;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <CreateTodoMutation>response.data.createTodo;
  }
  async UpdateTodo(
    input: UpdateTodoInput,
    condition?: ModelTodoConditionInput
  ): Promise<UpdateTodoMutation> {
    const statement = `mutation UpdateTodo($input: UpdateTodoInput!, $condition: ModelTodoConditionInput) {
        updateTodo(input: $input, condition: $condition) {
          __typename
          content
          id
          createdAt
          updatedAt
          owner
        }
      }`;
    const gqlAPIServiceArguments: any = {
      input
    };
    if (condition) {
      gqlAPIServiceArguments.condition = condition;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <UpdateTodoMutation>response.data.updateTodo;
  }
  async DeleteTodo(
    input: DeleteTodoInput,
    condition?: ModelTodoConditionInput
  ): Promise<DeleteTodoMutation> {
    const statement = `mutation DeleteTodo($input: DeleteTodoInput!, $condition: ModelTodoConditionInput) {
        deleteTodo(input: $input, condition: $condition) {
          __typename
          content
          id
          createdAt
          updatedAt
          owner
        }
      }`;
    const gqlAPIServiceArguments: any = {
      input
    };
    if (condition) {
      gqlAPIServiceArguments.condition = condition;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <DeleteTodoMutation>response.data.deleteTodo;
  }
  async GetPatient(
    ssn: string,
    givenName: string,
    familyName: string
  ): Promise<GetPatientQuery> {
    const statement = `query GetPatient($ssn: ID!, $givenName: String!, $familyName: String!) {
        getPatient(ssn: $ssn, givenName: $givenName, familyName: $familyName) {
          __typename
          ssn
          givenName
          familyName
          createdAt
          updatedAt
        }
      }`;
    const gqlAPIServiceArguments: any = {
      ssn,
      givenName,
      familyName
    };
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <GetPatientQuery>response.data.getPatient;
  }
  async ListPatients(
    ssn?: string,
    givenNameFamilyName?: ModelPatientPrimaryCompositeKeyConditionInput,
    filter?: ModelPatientFilterInput,
    limit?: number,
    nextToken?: string,
    sortDirection?: ModelSortDirection
  ): Promise<ListPatientsQuery> {
    const statement = `query ListPatients($ssn: ID, $givenNameFamilyName: ModelPatientPrimaryCompositeKeyConditionInput, $filter: ModelPatientFilterInput, $limit: Int, $nextToken: String, $sortDirection: ModelSortDirection) {
        listPatients(
          ssn: $ssn
          givenNameFamilyName: $givenNameFamilyName
          filter: $filter
          limit: $limit
          nextToken: $nextToken
          sortDirection: $sortDirection
        ) {
          __typename
          items {
            __typename
            ssn
            givenName
            familyName
            createdAt
            updatedAt
          }
          nextToken
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (ssn) {
      gqlAPIServiceArguments.ssn = ssn;
    }
    if (givenNameFamilyName) {
      gqlAPIServiceArguments.givenNameFamilyName = givenNameFamilyName;
    }
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    if (limit) {
      gqlAPIServiceArguments.limit = limit;
    }
    if (nextToken) {
      gqlAPIServiceArguments.nextToken = nextToken;
    }
    if (sortDirection) {
      gqlAPIServiceArguments.sortDirection = sortDirection;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <ListPatientsQuery>response.data.listPatients;
  }
  async GetMedicalAppointment(
    appointmentReference: string
  ): Promise<GetMedicalAppointmentQuery> {
    const statement = `query GetMedicalAppointment($appointmentReference: ID!) {
        getMedicalAppointment(appointmentReference: $appointmentReference) {
          __typename
          appointmentReference
          patient {
            __typename
            ssn
            givenName
            familyName
            createdAt
            updatedAt
          }
          provider
          date
          createdAt
          updatedAt
          medicalAppointmentPatientSsn
          medicalAppointmentPatientGivenName
          medicalAppointmentPatientFamilyName
        }
      }`;
    const gqlAPIServiceArguments: any = {
      appointmentReference
    };
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <GetMedicalAppointmentQuery>response.data.getMedicalAppointment;
  }
  async ListMedicalAppointments(
    appointmentReference?: string,
    filter?: ModelMedicalAppointmentFilterInput,
    limit?: number,
    nextToken?: string,
    sortDirection?: ModelSortDirection
  ): Promise<ListMedicalAppointmentsQuery> {
    const statement = `query ListMedicalAppointments($appointmentReference: ID, $filter: ModelMedicalAppointmentFilterInput, $limit: Int, $nextToken: String, $sortDirection: ModelSortDirection) {
        listMedicalAppointments(
          appointmentReference: $appointmentReference
          filter: $filter
          limit: $limit
          nextToken: $nextToken
          sortDirection: $sortDirection
        ) {
          __typename
          items {
            __typename
            appointmentReference
            provider
            date
            createdAt
            updatedAt
            medicalAppointmentPatientSsn
            medicalAppointmentPatientGivenName
            medicalAppointmentPatientFamilyName
          }
          nextToken
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (appointmentReference) {
      gqlAPIServiceArguments.appointmentReference = appointmentReference;
    }
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    if (limit) {
      gqlAPIServiceArguments.limit = limit;
    }
    if (nextToken) {
      gqlAPIServiceArguments.nextToken = nextToken;
    }
    if (sortDirection) {
      gqlAPIServiceArguments.sortDirection = sortDirection;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <ListMedicalAppointmentsQuery>response.data.listMedicalAppointments;
  }
  async GetTodo(id: string): Promise<GetTodoQuery> {
    const statement = `query GetTodo($id: ID!) {
        getTodo(id: $id) {
          __typename
          content
          id
          createdAt
          updatedAt
          owner
        }
      }`;
    const gqlAPIServiceArguments: any = {
      id
    };
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <GetTodoQuery>response.data.getTodo;
  }
  async ListTodos(
    filter?: ModelTodoFilterInput,
    limit?: number,
    nextToken?: string
  ): Promise<ListTodosQuery> {
    const statement = `query ListTodos($filter: ModelTodoFilterInput, $limit: Int, $nextToken: String) {
        listTodos(filter: $filter, limit: $limit, nextToken: $nextToken) {
          __typename
          items {
            __typename
            content
            id
            createdAt
            updatedAt
            owner
          }
          nextToken
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    if (limit) {
      gqlAPIServiceArguments.limit = limit;
    }
    if (nextToken) {
      gqlAPIServiceArguments.nextToken = nextToken;
    }
    const response = (await API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    )) as any;
    return <ListTodosQuery>response.data.listTodos;
  }
  OnCreatePatientListener(
    filter?: ModelSubscriptionPatientFilterInput
  ): Observable<
    SubscriptionResponse<Pick<__SubscriptionContainer, "onCreatePatient">>
  > {
    const statement = `subscription OnCreatePatient($filter: ModelSubscriptionPatientFilterInput) {
        onCreatePatient(filter: $filter) {
          __typename
          ssn
          givenName
          familyName
          createdAt
          updatedAt
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    return API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    ) as Observable<
      SubscriptionResponse<Pick<__SubscriptionContainer, "onCreatePatient">>
    >;
  }

  OnUpdatePatientListener(
    filter?: ModelSubscriptionPatientFilterInput
  ): Observable<
    SubscriptionResponse<Pick<__SubscriptionContainer, "onUpdatePatient">>
  > {
    const statement = `subscription OnUpdatePatient($filter: ModelSubscriptionPatientFilterInput) {
        onUpdatePatient(filter: $filter) {
          __typename
          ssn
          givenName
          familyName
          createdAt
          updatedAt
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    return API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    ) as Observable<
      SubscriptionResponse<Pick<__SubscriptionContainer, "onUpdatePatient">>
    >;
  }

  OnDeletePatientListener(
    filter?: ModelSubscriptionPatientFilterInput
  ): Observable<
    SubscriptionResponse<Pick<__SubscriptionContainer, "onDeletePatient">>
  > {
    const statement = `subscription OnDeletePatient($filter: ModelSubscriptionPatientFilterInput) {
        onDeletePatient(filter: $filter) {
          __typename
          ssn
          givenName
          familyName
          createdAt
          updatedAt
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    return API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    ) as Observable<
      SubscriptionResponse<Pick<__SubscriptionContainer, "onDeletePatient">>
    >;
  }

  OnCreateMedicalAppointmentListener(
    filter?: ModelSubscriptionMedicalAppointmentFilterInput
  ): Observable<
    SubscriptionResponse<
      Pick<__SubscriptionContainer, "onCreateMedicalAppointment">
    >
  > {
    const statement = `subscription OnCreateMedicalAppointment($filter: ModelSubscriptionMedicalAppointmentFilterInput) {
        onCreateMedicalAppointment(filter: $filter) {
          __typename
          appointmentReference
          patient {
            __typename
            ssn
            givenName
            familyName
            createdAt
            updatedAt
          }
          provider
          date
          createdAt
          updatedAt
          medicalAppointmentPatientSsn
          medicalAppointmentPatientGivenName
          medicalAppointmentPatientFamilyName
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    return API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    ) as Observable<
      SubscriptionResponse<
        Pick<__SubscriptionContainer, "onCreateMedicalAppointment">
      >
    >;
  }

  OnUpdateMedicalAppointmentListener(
    filter?: ModelSubscriptionMedicalAppointmentFilterInput
  ): Observable<
    SubscriptionResponse<
      Pick<__SubscriptionContainer, "onUpdateMedicalAppointment">
    >
  > {
    const statement = `subscription OnUpdateMedicalAppointment($filter: ModelSubscriptionMedicalAppointmentFilterInput) {
        onUpdateMedicalAppointment(filter: $filter) {
          __typename
          appointmentReference
          patient {
            __typename
            ssn
            givenName
            familyName
            createdAt
            updatedAt
          }
          provider
          date
          createdAt
          updatedAt
          medicalAppointmentPatientSsn
          medicalAppointmentPatientGivenName
          medicalAppointmentPatientFamilyName
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    return API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    ) as Observable<
      SubscriptionResponse<
        Pick<__SubscriptionContainer, "onUpdateMedicalAppointment">
      >
    >;
  }

  OnDeleteMedicalAppointmentListener(
    filter?: ModelSubscriptionMedicalAppointmentFilterInput
  ): Observable<
    SubscriptionResponse<
      Pick<__SubscriptionContainer, "onDeleteMedicalAppointment">
    >
  > {
    const statement = `subscription OnDeleteMedicalAppointment($filter: ModelSubscriptionMedicalAppointmentFilterInput) {
        onDeleteMedicalAppointment(filter: $filter) {
          __typename
          appointmentReference
          patient {
            __typename
            ssn
            givenName
            familyName
            createdAt
            updatedAt
          }
          provider
          date
          createdAt
          updatedAt
          medicalAppointmentPatientSsn
          medicalAppointmentPatientGivenName
          medicalAppointmentPatientFamilyName
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    return API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    ) as Observable<
      SubscriptionResponse<
        Pick<__SubscriptionContainer, "onDeleteMedicalAppointment">
      >
    >;
  }

  OnCreateTodoListener(
    filter?: ModelSubscriptionTodoFilterInput,
    owner?: string
  ): Observable<
    SubscriptionResponse<Pick<__SubscriptionContainer, "onCreateTodo">>
  > {
    const statement = `subscription OnCreateTodo($filter: ModelSubscriptionTodoFilterInput, $owner: String) {
        onCreateTodo(filter: $filter, owner: $owner) {
          __typename
          content
          id
          createdAt
          updatedAt
          owner
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    if (owner) {
      gqlAPIServiceArguments.owner = owner;
    }
    return API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    ) as Observable<
      SubscriptionResponse<Pick<__SubscriptionContainer, "onCreateTodo">>
    >;
  }

  OnUpdateTodoListener(
    filter?: ModelSubscriptionTodoFilterInput,
    owner?: string
  ): Observable<
    SubscriptionResponse<Pick<__SubscriptionContainer, "onUpdateTodo">>
  > {
    const statement = `subscription OnUpdateTodo($filter: ModelSubscriptionTodoFilterInput, $owner: String) {
        onUpdateTodo(filter: $filter, owner: $owner) {
          __typename
          content
          id
          createdAt
          updatedAt
          owner
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    if (owner) {
      gqlAPIServiceArguments.owner = owner;
    }
    return API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    ) as Observable<
      SubscriptionResponse<Pick<__SubscriptionContainer, "onUpdateTodo">>
    >;
  }

  OnDeleteTodoListener(
    filter?: ModelSubscriptionTodoFilterInput,
    owner?: string
  ): Observable<
    SubscriptionResponse<Pick<__SubscriptionContainer, "onDeleteTodo">>
  > {
    const statement = `subscription OnDeleteTodo($filter: ModelSubscriptionTodoFilterInput, $owner: String) {
        onDeleteTodo(filter: $filter, owner: $owner) {
          __typename
          content
          id
          createdAt
          updatedAt
          owner
        }
      }`;
    const gqlAPIServiceArguments: any = {};
    if (filter) {
      gqlAPIServiceArguments.filter = filter;
    }
    if (owner) {
      gqlAPIServiceArguments.owner = owner;
    }
    return API.graphql(
      graphqlOperation(statement, gqlAPIServiceArguments)
    ) as Observable<
      SubscriptionResponse<Pick<__SubscriptionContainer, "onDeleteTodo">>
    >;
  }
}
