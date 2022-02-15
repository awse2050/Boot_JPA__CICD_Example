package com.example.bootex.domains.board.presentation;

import com.example.bootex.domains.board.entity.Board;
import com.example.bootex.domains.board.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

@RestController
@RequiredArgsConstructor
public class BoardApiController {

    private static final String BOARD_API_URI = "/api/board";

    private final BoardService boardService;

    @PostMapping(value = BOARD_API_URI)
    public ResponseEntity<String> register(@RequestBody Board board) {

        Long boardId = boardService.register(board);

        return Objects.nonNull(boardId) ? new ResponseEntity<>("register", HttpStatus.CREATED) :
                    new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
    }

}
