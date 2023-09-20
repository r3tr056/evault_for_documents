
pragma solidity ^0.4.8;

contract ECertificateInterface {
    // Methods 

    // if the certificate is valid or not
    function isValid() returns (bool);
    // if the certificate has been approved or not
    function isApproved() returns (bool);
    // transfer the ownership of the document
    function transferDoc(address _to) const returns (bool success);
    // transfer the ownership of a owned document to another client
    function transferFrom(address _from, address _to) const returns (bool success);
    // submit for approval and storage into the chain
    function approve(address _holder, address _client) const returns (bool success);

    // Events
    // Triggered when the Transfer of the Document happens
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // Triggered when the Approval of the Document is complete
    event Approval(address indexed _holder, address indexed _client);
}

contract ECertificate is ECertificateInterface {
    string public constant symbol = "CERT";
    string public constant name = "ECertificate";
    
    struct CertMetadata {
        string cert_name;
        string cert_sub;
        address issuer_address;
        address holder_address;
        uint8 constant version;
    }

    struct Cert {
        uint256 cert_serial_no;

        CertMetadata cert_metadata;
        string cert_content;
        string issuer_name;
        string holder_name;

        string dig_signature;
        string dig_signature_algo;

        string issuer_uid;
        string sub_uid;
    }

    //
}