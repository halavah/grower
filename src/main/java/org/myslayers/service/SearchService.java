package org.myslayers.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.util.List;
import org.myslayers.vo.PostVo;

public interface SearchService {

    IPage search(Page page, String keyword);

    int initEsData(List<PostVo> records);
}
