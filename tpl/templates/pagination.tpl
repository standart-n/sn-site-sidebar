<div class='container-fluid'>
  <div class='row-fluid'>
    <div class='span12'>
      <div class='pagination pagination-centered'>
        <ul>
          <li class='{if isset($prev)}{if (!$prev)}disabled{/if}{/if}'>
            <a href='#' id='prev'>«</a>
          </li>
          {if isset($pagination)}
          {foreach from=$pagination item=key}
          <li class='{if isset($key.hidden)}hidden-phone{/if} {if isset($key.active)}active{/if}'>
            <a class='list' data-page='{if isset($key.page)}{$key.page}{/if}' href='#'>
              {if isset($key.page)}{$key.page}{/if}
            </a>
          </li>
          {/foreach}
          {/if}
          <li class='{if isset($next)}{if (!$next)}disabled{/if}{/if}'>
            <a href='#' id='next'>»</a>
          </li>
        </ul>
        <input id='page' type='hidden' value='{if isset($page)}{$page}{/if}' />
      </div>
    </div>
  </div>
</div>
