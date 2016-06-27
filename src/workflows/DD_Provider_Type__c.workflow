<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>DD_Years_of_Service_Update</fullName>
        <field>DD_Years_of_Service__c</field>
        <formula>TEXT( YEAR( DD_End_Date__c ) - YEAR( DD_Start_Date__c ))</formula>
        <name>Years of Service Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>DD Provider Type Years of Service Tracking</fullName>
        <actions>
            <name>DD_Years_of_Service_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( DD_Start_Date__c )  ||  ISCHANGED( DD_End_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
