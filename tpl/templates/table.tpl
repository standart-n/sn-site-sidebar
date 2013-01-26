
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
		<table class="table table-bordered table-condensed table-striped">
			<thead>
				<tr>
					<th>
						{if ($order=="calldate")}
							<a href="#" class="sort btn btn-mini btn-primary" data-order="calldate" data-grad="{if ($grad=="asc")}desc{else}asc{/if}">
								<i class="hidden-phone icon-arrow-{if ($grad=="asc")}up{else}down{/if} icon-white"></i> Дата
							</a>
						{else}
							<a href="#" class="sort btn btn-mini" data-order="calldate" data-grad="asc">
								<i class="hidden-phone icon-arrow-up"></i> Дата
							</a>
						{/if}
					</th>
					<th>
						{if ($order=="src_name")}
							<a href="#" class="sort btn btn-mini btn-primary" data-order="src_name" data-grad="{if ($grad=="asc")}desc{else}asc{/if}">
								<i class="hidden-phone icon-arrow-{if ($grad=="asc")}up{else}down{/if} icon-white"></i> От_кого
							</a>
						{else}
							<a href="#" class="sort btn btn-mini" data-order="src_name" data-grad="asc">
								<i class="hidden-phone icon-arrow-up"></i> От_кого
							</a>
						{/if}
					</th>
					<th class="hidden">
						Номер
					</th>
					<th>
						{if ($order=="dst_name")}
							<a href="#" class="sort btn btn-mini btn-primary" data-order="dst_name" data-grad="{if ($grad=="asc")}desc{else}asc{/if}">
								<i class="hidden-phone icon-arrow-{if ($grad=="asc")}up{else}down{/if} icon-white"></i> Кому
							</a>
						{else}
							<a href="#" class="sort btn btn-mini" data-order="dst_name" data-grad="asc">
								<i class="hidden-phone icon-arrow-up"></i> Кому
							</a>
						{/if}
					</th>
					<th class="hidden">
						Номер
					</th>
					<th>
						<a href="#" class="btn btn-mini disabled">
							Запись
						</a>
					</th>
					<th class="hidden-phone">
						<a href="#" class="btn btn-mini disabled">
							Действие
						</a>
					</th>
					<th class="hidden-phone">
						{if ($order=="billsec")}
							<a href="#" class="sort btn btn-mini btn-primary" data-order="billsec" data-grad="{if ($grad=="asc")}desc{else}asc{/if}">
								<i class="hidden-phone icon-arrow-{if ($grad=="asc")}up{else}down{/if} icon-white"></i> Длит.(c)
							</a>
						{else}
							<a href="#" class="sort btn btn-mini" data-order="billsec" data-grad="asc">
								<i class="hidden-phone icon-arrow-up"></i> Длит.(c)
							</a>
						{/if}
					</th>
					<input id="order" type="hidden" value="{$order}">
					<input id="grad" type="hidden" value="{$grad}">
				</tr>
			</thead>
			<tbody>
			{if isset($cdr)}
				{foreach from=$cdr item=key}
					<tr>
						<td>{$key.post_t} <small>{$key.post_d}</small></td>
						<td><small><div class="fb-name {$key.src_hash}">{$key.src_name}</div></small> <small><a class="tel" href="#">{$key.src}</a></small></td>
						<td class="hidden">{$key.id}</td>
						<td><small><div class="fb-name {$key.dst_hash}">{$key.dst_name}</div></small> <small><a class="tel" href="#">{$key.dst}</a></small></td>
						<td class="hidden">{$key.id}</td>
						<td>
							{if (!$key.listen)}
								<span class="label label-{$key.status_class}">{$key.status_rus}</span>
							{else}
								{if isset($key.path_audio)}
									<div class="btn-group">
										<a href="#" class="btn btn-primary btn-mini play" data-id="{$key.id}" data-src="{$key.path_audio}"><i class="icon-play icon-white"></i></a>
										<a href="{$key.path_audio}" target="_blank" class="btn btn-mini"><i class="icon-download-alt"></i></a>
									</div>
								{/if}
							{/if}
						</td>
						<td class="hidden-phone"><small>{$key.lastapp_rus}</small></td>
						<td class="hidden-phone">
							<div class="progress">
								<div class="bar bar-warning" style="width:{$key.duration_in_pr}%;"><small>{$key.duration_in}</small></div>
								<div class="bar bar-success" style="width:{$key.duration_call_pr}%;"><strong>{$key.duration_call}</strong></div>
								<div class="bar bar-danger" style="width:{$key.duration_error_pr}%;">{$key.duration_error}</div>
							</div>
						</td>
					</tr>
				{/foreach}
			{/if}
			</tbody>
		</table>		
		</div>
		<div class="hidden">
			{if isset($phones)}
				{foreach from=$phones item=key}
					<input class="no-fb" type="hidden" value="{$key}">
				{/foreach}
			{/if}
		</div>
	</div>
</div>
