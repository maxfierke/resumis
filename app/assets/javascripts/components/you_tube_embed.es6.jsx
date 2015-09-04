class YouTubeEmbed extends React.Component {
  getEmbedUrl() {
    var ytBase = "//www.youtube.com/embed/";

    return ytBase + encodeURIComponent(this.props.url);
  }

  render () {
    return (
      <div className="embed-responsive embed-responsive-16by9">
        <iframe className="embed-responsive-item" src={this.getEmbedUrl()} allowFullScreen></iframe>
      </div>
    );
  }
}

YouTubeEmbed.propTypes = {
  url: React.PropTypes.string
};
