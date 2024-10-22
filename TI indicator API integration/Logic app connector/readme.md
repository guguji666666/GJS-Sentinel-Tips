# Logic app connector

## Built-in new connector in logic app
[Threat Intelligence - Upload STIX Objects (Preview)](https://learn.microsoft.com/en-us/connectors/azuresentinel/#threat-intelligence---upload-indicators-of-compromise-(v2)-(preview))

![image](https://github.com/user-attachments/assets/16077ebb-f955-4c4d-8dc3-996e2ddda654)


Sample test <br>
![image](https://github.com/user-attachments/assets/522b9d9a-1224-4b33-9c57-5888ebb92363)


Sample reuqest body could be found [here](https://learn.microsoft.com/en-us/azure/sentinel/upload-indicators-api#sample-request-body) <br>
```json
{
    "sourcesystem": "test", 
    "indicators":[
        {
            "type": "indicator",
            "spec_version": "2.1",
            "id": "indicator--10000003-71a2-445c-ab86-927291df48f8", 
            "name": "Test Indicator 1",
            "created": "2010-02-26T18:29:07.778Z", 
            "modified": "2011-02-26T18:29:07.778Z",
            "pattern": "[ipv4-addr:value = '172.29.6.7']", 
            "pattern_type": "stix",
            "valid_from": "2015-02-26T18:29:07.778Z"
        },
        {
            "type": "indicator",
            "spec_version": "2.1",
            "id": "indicator--67e62408-e3de-4783-9480-f595d4fdae52", 
            "created": "2023-01-01T18:29:07.778Z",
            "modified": "2025-02-26T18:29:07.778Z",
            "created_by_ref": "identity--19f33886-d196-468e-a14d-f37ff0658ba7", 
            "revoked": false,
            "labels": [
                "label 1",
                "label 2"
            ],
            "confidence": 55, 
            "lang": "en", 
            "external_references": [
                {
                    "source_name": "External Test Source", 
                    "description": "Test Report",
                    "external_id": "e8085f3f-f2b8-4156-a86d-0918c98c498f", 
                    "url": "https://fabrikam.com//testreport.json",
                    "hashes": {
                        "SHA-256": "6db12788c37247f2316052e142f42f4b259d6561751e5f401a1ae2a6df9c674b"
                    }
                }
            ],
            "object_marking_refs": [
                "marking-definition--613f2e26-407d-48c7-9eca-b8e91df99dc9"
            ],
            "granular_markings": [
                {
                    "marking_ref": "marking-definition--beb3ec79-03aa-4594-ad24-09982d399b80", 
                    "selectors": [ "description", "labels" ],
                    "lang": "en"
                }
            ],
            "name": "Test Indicator 2",
            "description": "This is a test indicator to demo valid fields", 
            "indicator_types": [
                "threatstream-severity-low", "threatstream-confidence-80"
            ],
            "pattern": "[ipv4-addr:value = '192.168.1.1']", 
            "pattern_type": "stix",
            "pattern_version": "2.1",
            "valid_from": "2023-01-01T18:29:07.778Z", 
            "valid_until": "2025-02-26T18:29:07.778Z",
            "kill_chain_phases": [
                {
                    "kill_chain_name": "lockheed-martin-cyber-kill-chain", 
                    "phase_name": "reconnaissance"
                }
            ]
        }
    ]
}
```
