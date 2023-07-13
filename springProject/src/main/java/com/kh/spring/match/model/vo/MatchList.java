package com.kh.spring.match.model.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MatchList {
	private int no;
	private LocalDateTime matchdate;
	private String matchtime;
	private String gymAddress;
	private String gymDetailaddress;
	private String proNick;
	private String userId;
	private String matchdatestring;
	private String userId1;
	private String userId2;
	private String matchNo;
	private String challenger1;
	private String challenger2;
	private String challenger3;
	private String challenger4;
	private String challenger5;
}
