class VimeoEmbed extends React.Component {
  getEmbedUrl() {
    var vimeoBase = "//player.vimeo.com/video/";

    return vimeoBase + encodeURIComponent(this.props.url);
  }

  render () {
    return (
      <div className="embed-responsive embed-responsive-16by9">
        <iframe className="embed-responsive-item" src={this.getEmbedUrl()} allowFullScreen></iframe>
      </div>
    );
  }
}

VimeoEmbed.propTypes = {
  url: React.PropTypes.string
};
