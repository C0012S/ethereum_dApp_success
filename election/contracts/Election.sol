pragma solidity 0.5.16;

contract Election { 
    // Model a Candidate(후보자 모델링)
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // Read/write Candidates(위의 struct인스턴스를 저장, 후보자아이디로 후보자 조회)
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count(후보자들의 수)
    uint public candidatesCount;

    //2명의 후보자 생성
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    //후보자를 추가하는 함수 생성
    function addCandidate (string memory _name) private {
        candidatesCount ++; //후보자수를 1씩 증가
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);//증가된 후보자수를 id로 사용
    }

    //투표 기능 추가하기
    function vote(uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender],"This Voter has already voted!");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "There is no such candidate");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidatte vote Count
        candidates[_candidateId].voteCount++;

        //triger voted event
        emit votedEvent(_candidateId);
    }

    //account가 투표를 완료했을 때 클라이언트 쪽을 업데이트하거나 리프레쉬하도록 하는법
    event votedEvent (
        uint indexed _candidateId
    );

}